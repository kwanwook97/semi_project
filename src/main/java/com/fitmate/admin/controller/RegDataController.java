package com.fitmate.admin.controller;

import com.fitmate.admin.service.RegDataService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class RegDataController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired RegDataService regData_service;

	// 세션 체크
	String page = "";
	public void checkPermit(String addr, Model model, HttpSession session) {
		if (session.getAttribute("loginIdx") == null) {
			model.addAttribute("msg", "관리자 로그인이 필요한 페이지입니다.");
			if (addr.equals("") || addr == null) {
				model.addAttribute("addr", "redirect:/admin_dashboard.go");
			} else {
				model.addAttribute("addr", addr);
			}
			page = "admin_login";
		}
	}

	// 헬스 MBTI 질문 관리
	@RequestMapping (value = "/admin_regMbtiq.go")
	public String regMbtiQuestion (Model model, HttpSession session) {
		page = "admin_regMbtiq";
		checkPermit("redirect:/admin_regMbtiq.go", model, session);
		model.addAttribute("list", regData_service.regMbtiQuestion());
		return page;
	}

	@RequestMapping (value = "/admin_insertMbtiq.do")
	public String insertMbtiQuestion (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		int admin_idx = (int) session.getAttribute("loginIdx");
		int mbtiq_idx = regData_service.insertMbtiQuestion(params, admin_idx);
		page = "redirect:/admin_regMbtiq_sub.go?mbtiq_idx="+mbtiq_idx;
		checkPermit(page, model, session);
		return page;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub.go")
	public String regMbtiQuestionSub (String mbtiq_idx, Model model, HttpSession session) {
		page = "admin_regMbtiq_sub";
		checkPermit("redirect:/admin_regMbtiq_sub.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("mbtiq", regData_service.regMbtiQuestion());
			model.addAttribute("mbtir", regData_service.regMbtiResult());
			model.addAttribute("mbtisub", regData_service.regMbtisub(mbtiq_idx));
		}
		return page;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub_insertRow.ajax")
	@ResponseBody
	public Map<String, Object> regMbtiQuestionSubInsertRow (@RequestParam Map<String, String> params, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		int admin_idx = (int) session.getAttribute("loginIdx");
		result.put("status", regData_service.regMbtiQuestionSubInsertRow(params.get("mbtiq_idx"), admin_idx));
		return result;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub_updateQuestion.ajax")
	@ResponseBody
	public Map<String, Object> admin_regMbtiq_sub_updateQuestion (@RequestParam Map<String, String> params, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		int admin_idx = (int) session.getAttribute("loginIdx");
		result.put("status", regData_service.admin_regMbtiq_sub_updateQuestion(params, admin_idx));
		return result;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub_updateScore.ajax")
	@ResponseBody
	public Map<String, Object> admin_regMbtiq_sub_updateScore (@RequestParam Map<String, String> params, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		int admin_idx = (int) session.getAttribute("loginIdx");
		result.put("status", regData_service.admin_regMbtiq_sub_updateScore(params, admin_idx));
		return result;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub_deleteRow.ajax")
	@ResponseBody
	public Map<String, Object> admin_regMbtiq_sub_deleteRow (@RequestParam Map<String, String> params, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		int admin_idx = (int) session.getAttribute("loginIdx");
		result.put("status", regData_service.admin_regMbtiq_sub_deleteRow(params, admin_idx));
		return result;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub_deleteQuestion.ajax")
	@ResponseBody
	public Map<String, Object> admin_regMbtiq_sub_deleteQuestion (@RequestParam Map<String, String> params, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		int admin_idx = (int) session.getAttribute("loginIdx");
		result.put("status", regData_service.admin_regMbtiq_sub_deleteQuestion(params, admin_idx));
		return result;
	}

	@RequestMapping (value = "/admin_regMbtiqTrash.go")
	public String regMbtiQuestionTrash (Model model, HttpSession session) {
		page = "admin_regMbtiqTrash";
		checkPermit("redirect:/admin_regMbtiqTrash.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regMbtiQuestionTrash());
		}
		return page;
	}

	@RequestMapping (value = "/admin_restoreMbtiq.do")
	public String restoreMbtiQuestion (String mbtiq_idx, Model model, HttpSession session) {
		page = "redirect:/admin_regMbtiq.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.restoreMbtiQuestion(mbtiq_idx, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_regMbtiq_subTrash.go")
	public String regMbtiQuestionSubTrash (String mbtiq_idx, Model model, HttpSession session) {
		page = "admin_regMbtiq_subTrash";
		checkPermit("redirect:/admin_regMbtiq_subTrash.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("mbtiq", regData_service.regMbtiQuestion());
			model.addAttribute("mbtir", regData_service.regMbtiResultTrash());
			model.addAttribute("mbtisub", regData_service.regMbtisubTrash(mbtiq_idx));
		}
		return page;
	}

	@RequestMapping (value = "/admin_regMbtiq_sub_restoreRow.ajax")
	@ResponseBody
	public Map<String, Object> admin_regMbtiq_sub_restoreRow (@RequestParam Map<String, String> params, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		int admin_idx = (int) session.getAttribute("loginIdx");
		result.put("status", regData_service.admin_regMbtiq_sub_restoreRow(params, admin_idx));
		return result;
	}

	// 헬스 MBTI 결과 관리
	@RequestMapping (value = "/admin_regMbtir.go")
	public String regMbtiResult (Model model, HttpSession session) {
		page = "admin_regMbtir";
		checkPermit("redirect:/admin_regMbtir.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regMbtiResult());
		}
		return page;
	}

	@RequestMapping (value = "/admin_regMbtir_insert.go")
	public String regMbtiResultInsert (Model model, HttpSession session) {
		page = "admin_regMbtir_insert";
		checkPermit("redirect:/admin_regMbtir_insert.go", model, session);
		return page;
	}

	@RequestMapping (value = "/admin_regMbtir_detail.go")
	public String regMbtiResultDetail (String mbtir_idx, Model model, HttpSession session) {
		page = "admin_regMbtir_detail";
		checkPermit("redirect:/admin_regMbtir_detail.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("mbtir", regData_service.regMbtiResult());
			model.addAttribute("list", regData_service.regMbtiResultDetail(mbtir_idx));
		}
		return page;
	}

	@RequestMapping (value = "/admin_insertMbtir.do")
	public String regMbtiResultInsert (MultipartFile[] mbtir_img, @RequestParam Map<String, String> params, Model model, HttpSession session) {
		int admin_idx = (int) session.getAttribute("loginIdx");
		int mbtir_idx = regData_service.regMbtiResultInsert(mbtir_img, params, admin_idx);
		page = "redirect:/admin_regMbtir_detail.go?mbtir_idx="+mbtir_idx;
		checkPermit(page, model, session);
		return page;
	}

	@RequestMapping (value = "/admin_updateMbtir.do")
	public String regMbtiResultDetail (MultipartFile[] mbtir_img, @RequestParam Map<String, String> params, Model model, HttpSession session) {
		int admin_idx = (int) session.getAttribute("loginIdx");
		regData_service.regMbtiResultDetail(mbtir_img, params, admin_idx);
		if (params.get("reg_type").equals("update")) {
			page = "redirect:/admin_regMbtir_detail.go?mbtir_idx="+params.get("mbtir_idx");
		} else if (params.get("reg_type").equals("delete")) {
			page = "redirect:/admin_regMbtir.go";
		}
		checkPermit(page, model, session);
		return page;
	}

	@RequestMapping (value = "/admin_regMbtirTrash.go")
	public String regMbtiResultTrash (Model model, HttpSession session) {
		page = "admin_regMbtirTrash";
		checkPermit("redirect:/admin_regMbtirTrash.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regMbtiResultTrash());
		}
		return page;
	}

	@RequestMapping (value = "/admin_restoreMbtir.do")
	public String restoreMbtiResult (String mbtir_idx, Model model, HttpSession session) {
		page = "redirect:/admin_regMbtir.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.restoreMbtiResult(mbtir_idx, admin_idx);
		}
		return page;
	}

	// 지역 정보 관리
	@RequestMapping (value = "/admin_regRegion.go")
	public String regRegion (Model model, HttpSession session) {
		page = "admin_regRegion";
		checkPermit("redirect:/admin_regRegion.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regRegion());
		}
		return page;
	}

	@RequestMapping (value = "/admin_updateRegion.do")
	public String regRegion (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regRegion.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.regRegion(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_insertRegion.do")
	public String insertRegion (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regRegion.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.insertRegion(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_regRegionTrash.go")
	public String regRegionTrash (Model model, HttpSession session) {
		page = "admin_regRegionTrash";
		checkPermit("redirect:/admin_regRegionTrash.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regRegionTrash());
		}
		return page;
	}

	@RequestMapping (value = "/admin_restoreRegion.do")
	public String restoreRegion (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regRegion.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.restoreRegion(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_regRegion_sub.go")
	public String regRegionSub (String region_idx, Model model, HttpSession session) {
		page = "admin_regRegion_sub";
		checkPermit("redirect:/admin_regRegion_sub.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("region", regData_service.regRegion());
			model.addAttribute("list", regData_service.regRegionSub(region_idx));
		}
		return page;
	}

	@RequestMapping (value = "/admin_updateRegion_sub.do")
	public String regRegionSub (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regRegion_sub.go?region_idx="+params.get("region_idx");
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.regRegionSub(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_insertRegion_sub.do")
	public String insertRegionSub (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regRegion_sub.go?region_idx="+params.get("region_idx");
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.insertRegionSub(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_regRegion_subTrash.go")
	public String regRegionSubTrash (String region_idx, Model model, HttpSession session) {
		page = "admin_regRegion_subTrash";
		checkPermit("redirect:/admin_regRegion_subTrash.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("region", regData_service.regRegion());
			model.addAttribute("list", regData_service.regRegionSubTrash(region_idx));
		}
		return page;
	}

	@RequestMapping (value = "/admin_restoreRegion_sub.do")
	public String restoreRegionSub (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regRegion_sub.go?region_idx="+params.get("region_idx");
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.restoreRegionSub(params, admin_idx);
		}
		return page;
	}

	// 신고 사유 관리
	@RequestMapping (value = "/admin_regReport.go")
	public String regReport (Model model, HttpSession session) {
		page = "admin_regReport";
		checkPermit("redirect:/admin_regReport.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regReport());
		}
		return page;
	}

	@RequestMapping (value = "/admin_updateReport.do")
	public String regReport (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regReport.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.regReport(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_insertReport.do")
	public String insertReport (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regReport.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.insertReport(params, admin_idx);
		}
		return page;
	}

	@RequestMapping (value = "/admin_regReportTrash.go")
	public String regReportTrash (Model model, HttpSession session) {
		page = "admin_regReportTrash";
		checkPermit("redirect:/admin_regReportTrash.go", model, session);
		if (session.getAttribute("loginIdx") != null) {
			model.addAttribute("list", regData_service.regReportTrash());
		}
		return page;
	}

	@RequestMapping (value = "/admin_restoreReport.do")
	public String restoreReport (@RequestParam Map<String, String> params, Model model, HttpSession session) {
		page = "redirect:/admin_regReport.go";
		checkPermit(page, model, session);
		if (session.getAttribute("loginIdx") != null) {
			int admin_idx = (int) session.getAttribute("loginIdx");
			regData_service.restoreReport(params, admin_idx);
		}
		return page;
	}

}
