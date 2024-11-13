package com.fitmate.schedule.service;

import com.fitmate.crew.dto.CrewScheduleMDTO;
import com.fitmate.schedule.dao.ScheduleDAO;
import com.fitmate.schedule.dto.ScheduleDTO;
import com.fitmate.schedule.dto.ScheduleFileDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalTime;
import java.util.*;

@Service
public class ScheduleService {
	@Autowired ScheduleDAO s_dao;
	Logger logger = LoggerFactory.getLogger(getClass());
    @Value("${spring.servlet.multipart.location}") String fileLocation;

	public Map<String,Object> getEvents(String id) {
		Map<String,Object> event_day = new HashMap<>();
		List<Map<String,Object>> crew_events = s_dao.getCrewEvents(id);
		List<Map<String,Object>> date  = s_dao.getEvents(id);
		event_day.put("date",date);
		event_day.put("crew_events",crew_events);

		return event_day;
	}

	public Map<String,Object> getJournal(String date, String id) {
		List<Map<String,Object>> journal_list = s_dao.getJournal(date,id);

		Map<String,Object> journal_total = new HashMap<>();
		List<Map<String,String>> file = s_dao.getfile(date,id);
		journal_total.put("content",journal_list);
		journal_total.put("files",file);


		/*if(!journal_list.isEmpty()){
			//journal_list
			logger.info("journal_list:{}",journal_list);
			//그냥 가져와서 쓰면 안되나..?
			*//*Map<String,Object> idx_entry = journal_list.get(5);*//*
			*//*Set<String> key = idx_entry.keySet();
			logger.info("key:{}",key);*//*
			int idx = 0;
			//list 분리
			for(Map<String,Object> journal : journal_list){
				logger.info("journal:{}",journal);
				var keys = journal.keySet();
				for(String key : keys){
					logger.info("key:{}",key);

					if(key.equals("journal_idx")){
						idx = (int) journal.get(key);
					}
				}
			}

			logger.info("idx:{}",idx);



		}*/
		return journal_total;

	}

	public Boolean schedule_write(MultipartFile[] files, Map<String,String> content, String id) {
		logger.info("schedule_write service 도착");
		logger.info("id:{}",id);
		logger.info("content:{}",content);
		logger.info("files 길이 :{}",files.length);


		Boolean success = false;
		// ScheduleDTO
		ScheduleDTO scheduleDTO = new ScheduleDTO();
		scheduleDTO.setUser_id(id);
		scheduleDTO.setJournal_cate(Integer.parseInt(content.get("cate")));
		scheduleDTO.setJournal_content(content.get("textarea"));
		scheduleDTO.setDate(content.get("date"));
		scheduleDTO.setJournal_start(LocalTime.parse(content.get("start_time")));
		scheduleDTO.setJournal_end(LocalTime.parse(content.get("end_time")));

		//content부터 넣기
		if(s_dao.schedule_write(scheduleDTO)>0){//만약 content insert가 다 됐으면
			//content idx DTO에 저장 후 가져오기
			int idx = scheduleDTO.getJournal_idx();
			logger.info("idx:{}",idx);


			//file 저장

			//1. 파일 분리
			for(MultipartFile file : files){

				//byte
                try {
					//파일 이름
					//기존 이름
					String ori_filename = file.getOriginalFilename();
					logger.info("파일 존재 여부:{}",file.isEmpty());
					logger.info("ori_filename:{}",ori_filename);

					//만약 lastindex of가 잡히면 실행하도록
					int pos = ori_filename.lastIndexOf(".");

					//새 이름으로 바꾸기
					//확장자 뽑아오기
					if(pos>=0){ //만약에 ext가 있으면 수행하기
					String ext = ori_filename.substring(pos);
					logger.info("ext:{}",ext);


					//랜덤 이름 만들기 + 확장자
					String new_filename = UUID.randomUUID().toString() + ext;
					logger.info("new_filename:{}",new_filename);


					//byte 설정
                    byte[] arr = file.getBytes(); //바이트 추출

					//저장할 paths
					Path path = Paths.get(fileLocation+new_filename); //저장하려는 파일명 알아내기

					//파일에 적기(Files)
					Files.write(path,arr);//저장할 경로 , byte


					//DB에 넣기
					int updated_rows = s_dao.filewrite(idx,ori_filename,new_filename); //방금 적은 content idx에 파일 저장하기

					}

					} catch (Exception e) {
					e.printStackTrace();
				}


			}

		}
		return success;
	}

	public List<Map<String, Object>> crewplan_get(String date,String id) {
		logger.info("컨트롤러에서 전달받은 date :{}",date);
		return s_dao.crewplan_get(id,date);
	}

	//일지 삭제
	public int delete_journal(int idx) {
		logger.info("idx:{}",idx);
		//파일 정보 미리 저장 //파일이 있는지 보는 방법

		//1.파일이 있는지 확인하기..
		int file_exists =s_dao.check_file(idx);
		int updated_rows = 0;
		if(file_exists>0){

			//2. 파일이 있으면 파일 저장하고 진행
			List<ScheduleFileDTO> file = s_dao.getcurrentfile(idx);
				//파일 저장 성공했는지 확인
				if(!file.isEmpty()){ //file이 비어있지 않으면
					//글 삭제
					updated_rows = s_dao.deleteContent(idx);

					if(updated_rows>0){
					//파일 삭제
						//파일 DTO 분리
						for (ScheduleFileDTO fileDTO : file) {
							//1. 삭제하고 싶은 위치 지정 => 새로운 이름 기반
							File files = new File(fileLocation+ fileDTO.getNew_filename());
							//2. 만약 파일이 있으면 file 삭제 => DB는 이미 on deleteCascade로 삭제된 상태
							if(files.exists()){
								boolean success = files.delete();//파일 삭제
								logger.info("success:{}",success);
							}
						}

					}
				}

			//3. 파일 없으면 그냥 삭제
		}else{
			updated_rows = s_dao.deleteContent(idx);
			logger.info("글만 삭제:{}",updated_rows);
		}

		return updated_rows;
	}

	public void getJournal_detail(int idx, Model model) {
		logger.info("서비스에서 받은 idx:{}",idx);

		//해당 idx를 가진 file들 가져오기
		model.addAttribute("journal",s_dao.getJournal_detail(idx));
		model.addAttribute("file",s_dao.currentfile(idx));
	}


	public boolean delete_img(int file_idx) {
		int deleted = s_dao.delete_img(file_idx);
		boolean success = false;
		if(deleted>0){
			success = true;
		}
		return success;
	}

    public List<ScheduleDTO> crew_plan_detail(String date, String crewIdx, String id) {
		return s_dao.crew_plan_detail(date, crewIdx, id);
    }

	public List<CrewScheduleMDTO> crew_plan_members(int planidx) {
		return s_dao.crew_plan_members(planidx);
	}

	public Object update_content(Map<String,Object> param) {
		logger.info("받아온 param:{}",param);
		boolean success = false;
		int result = s_dao.update_content(param);
		if(result>0){
			success = true;
		}
		return success;
	}

	public boolean file_insert(String input, MultipartFile file) {
		int idx = Integer.parseInt(input);
		logger.info("idx:{}",idx);

		boolean success = false;
		//file을 newfilename과 orifilename으로 만들고 file에 직접 넣기
		String ori_filename = file.getOriginalFilename();
		logger.info("ori_filename:{}",ori_filename);

		String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
		logger.info("ext:{}",ext);

		String new_filename = UUID.randomUUID().toString() + ext;
		logger.info("new_filename:{}",new_filename);

		try {
            //1. 바이트 저장
			byte[]arr = file.getBytes();

			//2. 저장할 path 저장
			Path path = Paths.get(fileLocation+new_filename);

			//3. File 저장
			Files.write(path,arr);

			//4.DB에 작성
			int result = s_dao.filewrite(idx,ori_filename,new_filename);
			logger.info("idx:{}",idx);
			if(result>0){
				success = true;
			}
		} catch (IOException e) {
            throw new RuntimeException(e);
        }

		return success;
	}
}
