package com.fitmate.member.service;

import com.fitmate.admin.dto.RegCountyDTO;
import com.fitmate.member.dao.MemberDAO;
import com.fitmate.member.dto.MemberDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class MemberService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MemberDAO member_dao;
    @Value("${spring.servlet.multipart.location}") String fileLocation;

	// 유저 로그인
	public String login(String user_id, String pw) {
		String result = "";
		if (member_dao.login(user_id, pw) == 1){
			result = "pass";
		} else if (member_dao.checkid(user_id) == 0) {
			result = "invalidID";
		} else {
			result = "invalidPW";
		}
		return result;
	}

	// 회원 가입
	public List<RegCountyDTO> getRegion() {
		return member_dao.getRegion();
	}

	public boolean checkid(String user_id) {
		boolean result = false;
		if (member_dao.checkid(user_id) == 0 && user_id != null) {
			result = true;
		}
		return result;
	}

	public boolean checknick(String nick) {
		boolean result = false;
		if (member_dao.checknick(nick) == 0 && nick != null) {
			result = true;
		}
		return result;
	}

	public List<RegCountyDTO> getRegion2(String region_idx) {
		return member_dao.getRegion2(region_idx);
	}

	public boolean join(MultipartFile[] files, Map<String, String> params) {
		boolean result = false;
		if (member_dao.join(params) == 1 && member_dao.insertProfile(params) == 1){
			for (MultipartFile file : files) {
				if (file.getOriginalFilename().lastIndexOf(".") < 0) {
					if (member_dao.insertImg(params.get("user_id"), "") == 1){
						result = true;
					}
					break;
				} else {
					try {
						String ori_filename = file.getOriginalFilename();
						String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
						String new_filename = UUID.randomUUID().toString()+ext;
						byte[] arr = file.getBytes();
						Path path = Paths.get(fileLocation+new_filename);
						Files.write(path, arr);
						if (member_dao.insertImg(params.get("user_id"), new_filename) == 1){
							result = true;
						}
					} catch (IOException e) {}
				}
			}
		}
		return result;
	}

	// leftnav 프로필 불러오기
	public MemberDTO getProfile(String loginId) {
		return member_dao.getProfile(loginId);
	}

	// 내 프로필 조회
	public MemberDTO profile(String user_id) {
		return member_dao.profile(user_id);
	}

	// 정보 수정
	public boolean update(MultipartFile[] files, Map<String, String> params) {
		boolean result = false;

		// 정보 입력
		if (member_dao.update1(params) == 1 && member_dao.update2(params) == 1){
			String user_id = params.get("user_id");
			MemberDTO dto = member_dao.getProfile(user_id);

			// 파일 변경시 기존 파일 삭제
			if (params.get("fileIsUpdated").equals("true")){
				if (files.length > 0) {
					File file = new File(fileLocation+dto.getProfile());
					if (file.exists()) {
						file.delete();
					}
				}

				// 새 파일 업로드
				for (MultipartFile file : files) {
					if (file.getOriginalFilename().lastIndexOf(".") < 0) {
						if (member_dao.insertImg(params.get("user_id"), "") == 1){
							result = true;
						}
						break;
					} else {
						try {
							String ori_filename = file.getOriginalFilename();
							String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
							String new_filename = UUID.randomUUID().toString()+ext;
							byte[] arr = file.getBytes();
							Path path = Paths.get(fileLocation+new_filename);
							Files.write(path, arr);
							if (member_dao.insertImg(params.get("user_id"), new_filename) == 1){
								result = true;
							}
						} catch (IOException e) {}
					}
				}
			} else {
				result = true;
			}

		}

		return result;
	}

	// 프로필 이미지 삭제
	public void deleteImg(String user_id) {
		MemberDTO dto = member_dao.getProfile(user_id);
		if (member_dao.deleteImg(user_id) == 1){
			File file = new File(fileLocation+dto.getProfile());
			if (file.exists()) {
				file.delete();
			}
		}
	}

	// 비밀번호 변경
	public void updatepw(String user_id, String pw) {
		member_dao.updatepw(user_id, pw);
	}

	// 크루 이용 가능 여부 체크
	public LocalDateTime getPermit(String user_id) {
		return member_dao.getPermit(user_id);
	}
}
