package com.hfh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.PaperExamDao;
import com.hfh.dao.QuestionDao;
import com.hfh.dao.QuestionExamDao;
import com.hfh.domain.PaperExam;
import com.hfh.domain.Question;
import com.hfh.domain.QuestionExam;
import com.hfh.service.PaperExamService;
import com.hfh.utils.MyConstant;
import com.hfh.utils.PageBean;
import com.hfh.utils.QuestionExamBean;

@Service
@Transactional
public class PaperExamServiceImpl implements PaperExamService {
	
	@Autowired
	private PaperExamDao paperExamDao;
	@Autowired
	private QuestionDao questionDao;
	@Autowired
	private QuestionExamDao questionExamDao;
	
	
	@Override
	public void pageQuery(PageBean pageBean) {
		paperExamDao.pageQuery(pageBean);
	}


	@Override
	public void publishPaperExam(String ids) {
		changePaperExamStatus(ids, "paperExam.publish");		
	}


	@Override
	public void revokePaperExam(String ids) {
		changePaperExamStatus(ids, "paperExam.revoke");		
	}


	@Override
	public void deletePaperExam(String ids) {
		if (StringUtils.isNotBlank(ids)) {
			String[] paperIds = ids.split(",");
			for (String paperId : paperIds) {
				PaperExam paperExam = paperExamDao.findById(Long.parseLong(paperId));
				paperExamDao.delete(paperExam);
			}
		}
	}

	private void changePaperExamStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] newIds = ids.split(",");
			for (String newId : newIds) {
				paperExamDao.executeUpdate(queryName, Long.parseLong(newId));
			}
		}
	}

	@Override
	public void save(PaperExam model) {
		paperExamDao.save(model);
	}
	
	// 组卷
	@Override
	public void makeUpPaperExam(PaperExam model, int xuanze_number, int xuanze_weights, int tiankong_number,
			int tiankong_weights) {
		// 所有选择考题的id集合
		List<Long> allXuanZeQuestionsId = questionDao.findAllQuestionsIdByType(MyConstant.QUEST_TYPE_XUANZE);
		// 所有填空考题的id集合
		List<Long> allTianKongQuestionsId = questionDao.findAllQuestionsIdByType(MyConstant.QUEST_TYPE_TIANKONG);
		
		// 判断考题的数目大于组卷所需的题目数目
		if (xuanze_number > allXuanZeQuestionsId.size()) 
			return ;
		if (tiankong_number > allTianKongQuestionsId.size())
			return ;
		// 插入考卷信息并返回考卷id
		Serializable paper_id = paperExamDao.saveAndReturnId(model);
		// 存放需要插入数据库中的选择题集合
		List<QuestionExam> xuanzeList = new ArrayList<QuestionExam>();
		// 存放需要插入数据库中的填空题集合
		List<QuestionExam> tiankongList = new ArrayList<QuestionExam>();
		
		QuestionExam questionExam = null;
		
		Random random = new Random();
		for (int i = 0; i < xuanze_number; i++) {
			questionExam = new QuestionExam();
			int nextIdIndex = random.nextInt(allXuanZeQuestionsId.size());
			Long nextId = allXuanZeQuestionsId.remove(nextIdIndex);
			questionExam.setExam_weights(xuanze_weights);
			questionExam.setPaper_id(Long.parseLong(paper_id.toString()));
			questionExam.setQuest_id(nextId);
			questionExam.setExam_sequence(i + 1);
			xuanzeList.add(questionExam);
		}
		for (int i = 0; i < tiankong_number; i++) {
			questionExam = new QuestionExam();
			int nextIdIndex = random.nextInt(allTianKongQuestionsId.size());
			Long nextId = allTianKongQuestionsId.remove(nextIdIndex);
			questionExam.setExam_weights(tiankong_weights);
			questionExam.setPaper_id(Long.parseLong(paper_id.toString()));
			questionExam.setQuest_id(nextId);
			questionExam.setExam_sequence(i + 1 + xuanze_number);
			tiankongList.add(questionExam);
		}
		questionExamDao.saveQuestionExamBatch(xuanzeList);
		questionExamDao.saveQuestionExamBatch(tiankongList);
	}


	@Override
	public List<QuestionExamBean> findAllQuestionExamByPaperId(PaperExam model) {
		List<QuestionExamBean> questionExamBeanList = new ArrayList<QuestionExamBean>();
		List<QuestionExam> questionExamList = 
				questionExamDao.findByPaperId(model.getPaper_id());
		
		QuestionExamBean questionExamBean = null;
		for (QuestionExam temp : questionExamList) {
			questionExamBean = new QuestionExamBean();
			Question question = questionDao.findById(temp.getQuest_id());
			questionExamBean.setExam_id(temp.getExam_id());
			questionExamBean.setExam_weights(temp.getExam_weights());
			questionExamBean.setQuest_content(question.getQuest_content());
			questionExamBean.setQuest_result(question.getQuest_result());
			questionExamBean.setQuest_type(question.getQuest_type());
			questionExamBean.setExam_sequence(temp.getExam_sequence());
			questionExamBeanList.add(questionExamBean);
		}
		
		Collections.sort((List<QuestionExamBean>) questionExamBeanList);
		return questionExamBeanList;
	}


	@Override
	public List<QuestionExamBean> replaceQuestionExam(String ids) {
		if (StringUtils.isNotBlank(ids)) {
			// 需要被替换的考题的id
			String[] examIdsTemp = ids.split(",");
			// 被替换的考题数目
			int replaceSize = examIdsTemp.length;
			Long[] examIds = new Long[replaceSize];
			for (int i = 0; i < examIds.length; i++) {
				examIds[i] = Long.parseLong(examIdsTemp[i]);
			}
			// 放置需要被替换的考题
			List<QuestionExam> questionExamList = null;
			questionExamList = questionExamDao.findAllById(examIds);
			if (questionExamList == null) 
				return null;
			// 被替换的考题所属考卷id
			long paper_id = questionExamList.get(0).getPaper_id();
			// 存放需要被替换的题目的id
			Long[] questionIds = new Long[replaceSize];
			for (int i = 0; i < questionIds.length; i++) {
				questionIds[i] = questionExamList.get(i).getQuest_id();
			}
			
			List<Integer> questionTypes = questionDao.findQuestionsTypeByIds(questionIds);
			// 需要被替换的考题中选择题的数目
			int xuanze_number = 0;
			// 需要被替换的考题中填空题的数目
			int tiankong_number = 0;
			for (int temp : questionTypes) {
				if (temp == MyConstant.QUEST_TYPE_XUANZE)
					xuanze_number++;
				else if (temp == MyConstant.QUEST_TYPE_TIANKONG)
					tiankong_number++;
			}
			// 修改需要被替换的考题的quest_id
			Random random = new Random();
			if (xuanze_number > 0) {
				List<Long> allXuanZeQuestionsId = 
						questionDao.findAllQuestionsIdByType(MyConstant.QUEST_TYPE_XUANZE, questionIds);
				// 如果需要替换的选择题数目大于可以选择的选择题数目，则返回空
				if (xuanze_number > allXuanZeQuestionsId.size()) return null;
				for (int i = 0; i < xuanze_number; i++) {
					int nextIdIndex = random.nextInt(allXuanZeQuestionsId.size());
					long quest_id = allXuanZeQuestionsId.remove(nextIdIndex);
					questionExamList.get(i).setQuest_id(quest_id);
				}
			}
			if (tiankong_number > 0) {
				List<Long> allTianKongQuestionsId = 
						questionDao.findAllQuestionsIdByType(MyConstant.QUEST_TYPE_TIANKONG, questionIds);
				// 如果需要替换的填空题数目大于可以选择的填空题数目，则返回空
				if (tiankong_number > allTianKongQuestionsId.size()) return null;
				for (int i = 0; i < tiankong_number; i++) {
					int nextIdIndex = random.nextInt(allTianKongQuestionsId.size());
					long quest_id = allTianKongQuestionsId.remove(nextIdIndex);
					questionExamList.get(i + xuanze_number).setQuest_id(quest_id);
				}
			}
			// 更新考题
			questionExamDao.saveOrUpDateBatch(questionExamList);
			// 查询考卷下的所有考题
			PaperExam paperExam = new PaperExam();
			paperExam.setPaper_id(paper_id);
			return this.findAllQuestionExamByPaperId(paperExam);
		} else {
			return null;
		}
	}


}
