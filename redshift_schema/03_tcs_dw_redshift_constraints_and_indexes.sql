ALTER TABLE user_component_score
ADD CONSTRAINT pk_user_comp_score_id
PRIMARY KEY (user_component_score_id);

ALTER TABLE log_type_lu
ADD CONSTRAINT log_type_lu_pk
PRIMARY KEY (log_type_id);

ALTER TABLE update_log
ADD CONSTRAINT update_log_pkey
PRIMARY KEY (log_id);

ALTER TABLE project
ADD CONSTRAINT project_pkey
PRIMARY KEY (project_id);

ALTER TABLE contest
ADD CONSTRAINT contest_pkey
PRIMARY KEY (contest_id);

ALTER TABLE contest_project_xref
ADD CONSTRAINT con_proj_pkey
PRIMARY KEY (contest_id, project_id);


ALTER TABLE project_technology
ADD CONSTRAINT project_technology_pkey
PRIMARY KEY (project_id, project_technology_id);

ALTER TABLE project_platform
ADD CONSTRAINT project_platform_pkey
PRIMARY KEY (project_id, project_platform_id);

ALTER TABLE project_result
ADD CONSTRAINT proj_result_pkey
PRIMARY KEY (project_id, user_id);


ALTER TABLE submission_review
ADD CONSTRAINT sub_review_pkey
PRIMARY KEY (project_id, user_id, reviewer_id);


ALTER TABLE user_reliability
ADD CONSTRAINT user_reliability_pkey
PRIMARY KEY (user_id, phase_id);

ALTER TABLE event
ADD CONSTRAINT event_pkey
PRIMARY KEY (event_id);

ALTER TABLE user_event_xref
ADD CONSTRAINT usereventxref_pkey
PRIMARY KEY (user_id, event_id);

ALTER TABLE user_rank_type_lu
ADD CONSTRAINT user_rank_type_lu_pk
PRIMARY KEY (user_rank_type_id);

ALTER TABLE command
ADD CONSTRAINT command_pk
PRIMARY KEY (command_id);

ALTER TABLE command_group_lu
ADD CONSTRAINT command_group_lu_pk
PRIMARY KEY (command_group_id);

ALTER TABLE data_type_lu
ADD CONSTRAINT data_type_pk
PRIMARY KEY (data_type_id);

ALTER TABLE input_lu
ADD CONSTRAINT input_lu_pkey
PRIMARY KEY (input_id);

ALTER TABLE query
ADD CONSTRAINT query_pk
PRIMARY KEY (query_id);

ALTER TABLE query_input_xref
ADD CONSTRAINT query_input_pk
PRIMARY KEY (query_id, input_id);

ALTER TABLE command_query_xref
ADD CONSTRAINT commandqueryxref_pk
PRIMARY KEY (command_id, query_id);

ALTER TABLE submission_screening
ADD CONSTRAINT sub_screening_pkey
PRIMARY KEY (project_id, user_id);

ALTER TABLE review_resp
ADD CONSTRAINT review_resp_pkey
PRIMARY KEY (review_resp_id);

ALTER TABLE scorecard_template
ADD CONSTRAINT scorecard_template_pkey
PRIMARY KEY (scorecard_template_id);

ALTER TABLE evaluation_lu
ADD CONSTRAINT evaluation_pk
PRIMARY KEY (evaluation_id);

ALTER TABLE scorecard_response
ADD CONSTRAINT scorecard_response_pkey
PRIMARY KEY (scorecard_question_id, scorecard_id);

ALTER TABLE testcase_response
ADD CONSTRAINT testcase_response_pkey
PRIMARY KEY (scorecard_question_id, scorecard_id);

ALTER TABLE subjective_response
ADD CONSTRAINT subjective_response_pkey
PRIMARY KEY (scorecard_question_id, scorecard_id, sort);

ALTER TABLE appeal
ADD CONSTRAINT appeal_pkey
PRIMARY KEY (appeal_id);

ALTER TABLE testcase_appeal
ADD CONSTRAINT testcaseappeal_pkey
PRIMARY KEY (appeal_id);

ALTER TABLE project_review
ADD CONSTRAINT proj_review_pkey
PRIMARY KEY (project_id, reviewer_id);

ALTER TABLE season
ADD CONSTRAINT season_pk
PRIMARY KEY (season_id);

ALTER TABLE stage
ADD CONSTRAINT stage_pk
PRIMARY KEY (stage_id);

ALTER TABLE submission
ADD CONSTRAINT submission_pk
PRIMARY KEY (submission_id);

ALTER TABLE contest_prize
ADD CONSTRAINT contest_prize_pkey
PRIMARY KEY (contest_prize_id);

ALTER TABLE contest_stage_xref
ADD CONSTRAINT contest_stage_xref_pkey
PRIMARY KEY (contest_id, stage_id);

ALTER TABLE contest_season_xref
ADD CONSTRAINT contest_season_xref_pkey
PRIMARY KEY (contest_id, season_id);

ALTER TABLE streak_type_lu
ADD CONSTRAINT streak_type_lu_pkey
PRIMARY KEY (streak_type_id);

ALTER TABLE project_result_022707
ADD CONSTRAINT proj_result_pkey_022707
PRIMARY KEY (project_id, user_id);

ALTER TABLE contest_result
ADD CONSTRAINT contest_result_pk
PRIMARY KEY (contest_id, coder_id);

ALTER TABLE scorecard_question
ADD CONSTRAINT scorecard_question_pkey
PRIMARY KEY (scorecard_question_id);

ALTER TABLE user_rating
ADD CONSTRAINT pk_user_rating
PRIMARY KEY (user_id, phase_id);

ALTER TABLE dr_points
ADD CONSTRAINT pk_dr_points
PRIMARY KEY (dr_points_id);

ALTER TABLE track
ADD CONSTRAINT pk_track
PRIMARY KEY (track_id);

ALTER TABLE track_contest
ADD CONSTRAINT pk_track_contest
PRIMARY KEY (track_contest_id);

ALTER TABLE track_contest_results
ADD CONSTRAINT pk_track_contest_results
PRIMARY KEY (track_contest_id, user_id);

ALTER TABLE client_project_dim
ADD CONSTRAINT client_project_dim_pkey
PRIMARY KEY (client_project_id);

ALTER TABLE weekly_contest_stats
ADD CONSTRAINT weekly_contest_stats_pkey
PRIMARY KEY (client_project_id, tc_direct_project_id, project_category_id, week, month, year);

ALTER TABLE monthly_contest_stats
ADD CONSTRAINT monthly_contest_stats_pkey
PRIMARY KEY (client_project_id, tc_direct_project_id, project_category_id, month, year);

ALTER TABLE direct_project_dim
ADD CONSTRAINT direct_project_dim_pkey
PRIMARY KEY (direct_project_id);



ALTER TABLE user_achievement_rule
ADD CONSTRAINT pk_user_achievement_rule_id
PRIMARY KEY (user_achievement_rule_id);

ALTER TABLE user_achievement_type_lu
ADD CONSTRAINT pk_user_achievement_type_id
PRIMARY KEY (user_achievement_type_id);

ALTER TABLE user_achievement_xref
ADD CONSTRAINT pk_user_id_user_achievement_rule_id
PRIMARY KEY (user_id, user_achievement_rule_id);



ALTER TABLE update_log
ADD CONSTRAINT updatelog_logtypelu_fk
FOREIGN KEY (log_type_id)
REFERENCES log_type_lu (log_type_id);

ALTER TABLE project
ADD CONSTRAINT project_stage_fk
FOREIGN KEY (stage_id)
REFERENCES stage (stage_id);

ALTER TABLE contest
ADD CONSTRAINT contest_event_fk
FOREIGN KEY (event_id)
REFERENCES event (event_id);

ALTER TABLE submission_review
ADD CONSTRAINT review_template_fkey
FOREIGN KEY (scorecard_template_id)
REFERENCES scorecard_template (scorecard_template_id);

ALTER TABLE event
ADD CONSTRAINT userevent_event_fk
FOREIGN KEY (event_id)
REFERENCES event (event_id);

ALTER TABLE user_rank
ADD CONSTRAINT userrank_userranktypelu_fk
FOREIGN KEY (user_rank_type_id)
REFERENCES user_rank_type_lu (user_rank_type_id);

ALTER TABLE school_user_rank
ADD CONSTRAINT schooluserrank_userranktypelu_fk
FOREIGN KEY (user_rank_type_id)
REFERENCES user_rank_type_lu (user_rank_type_id);

ALTER TABLE country_user_rank
ADD CONSTRAINT countryuserrank_userranktypelu_fk
FOREIGN KEY (user_rank_type_id)
REFERENCES user_rank_type_lu (user_rank_type_id);

ALTER TABLE input_lu
ADD CONSTRAINT inputlu_datatype_fk
FOREIGN KEY (data_type_id)
REFERENCES data_type_lu (data_type_id);

ALTER TABLE query_input_xref
ADD CONSTRAINT queryinputs_query_fk
FOREIGN KEY (query_id)
REFERENCES query (query_id);

ALTER TABLE query_input_xref
ADD CONSTRAINT queryinput_inputlu_fk
FOREIGN KEY (input_id)
REFERENCES input_lu (input_id);

ALTER TABLE command_query_xref
ADD CONSTRAINT commandquery_command_fk
FOREIGN KEY (command_id)
REFERENCES command (command_id);

ALTER TABLE command_query_xref
ADD CONSTRAINT commandquery_query_fk
FOREIGN KEY (query_id)
REFERENCES query (query_id);

ALTER TABLE submission_screening
ADD CONSTRAINT screening_template_fkey
FOREIGN KEY (scorecard_template_id)
REFERENCES scorecard_template (scorecard_template_id);

ALTER TABLE scorecard_response
ADD CONSTRAINT question_response_fkey
FOREIGN KEY (scorecard_question_id)
REFERENCES scorecard_question (scorecard_question_id);

ALTER TABLE scorecard_response
ADD CONSTRAINT project_response_fkey
FOREIGN KEY (project_id)
REFERENCES project (project_id);

ALTER TABLE testcase_response
ADD CONSTRAINT question_testcase_fkey
FOREIGN KEY (scorecard_question_id)
REFERENCES scorecard_question (scorecard_question_id);

ALTER TABLE testcase_response
ADD CONSTRAINT project_testcase_fkey
FOREIGN KEY (project_id)
REFERENCES project (project_id);

ALTER TABLE subjective_response
ADD CONSTRAINT question_subjective_fkey
FOREIGN KEY (scorecard_question_id)
REFERENCES scorecard_question (scorecard_question_id);

ALTER TABLE subjective_response
ADD CONSTRAINT project_subjective_fkey
FOREIGN KEY (project_id)
REFERENCES project (project_id);

ALTER TABLE appeal
ADD CONSTRAINT appeal_question_fkey
FOREIGN KEY (scorecard_question_id)
REFERENCES scorecard_question (scorecard_question_id);

ALTER TABLE appeal
ADD CONSTRAINT appeal_project_fkey
FOREIGN KEY (project_id)
REFERENCES project (project_id);

ALTER TABLE appeal
ADD CONSTRAINT appeal_evaluation_fkey
FOREIGN KEY (raw_evaluation_id)
REFERENCES evaluation_lu (evaluation_id);

ALTER TABLE appeal
ADD CONSTRAINT appeal_finalevalulation_fkey
FOREIGN KEY (final_evaluation_id)
REFERENCES evaluation_lu (evaluation_id);

ALTER TABLE testcase_appeal
ADD CONSTRAINT testcaseappeal_question_fkey
FOREIGN KEY (scorecard_question_id)
REFERENCES scorecard_question (scorecard_question_id);

ALTER TABLE testcase_appeal
ADD CONSTRAINT testcase_project_fkey
FOREIGN KEY (project_id)
REFERENCES project (project_id);

ALTER TABLE stage
ADD CONSTRAINT stage_season_fk
FOREIGN KEY (season_id)
REFERENCES season (season_id);

ALTER TABLE command_execution
ADD CONSTRAINT commandexecution_command_fk
FOREIGN KEY (command_id)
REFERENCES command (command_id);

ALTER TABLE contest_prize
ADD CONSTRAINT fk_contest_prize_contest
FOREIGN KEY (contest_id)
REFERENCES contest (contest_id);

ALTER TABLE contest_stage_xref
ADD CONSTRAINT fk_contest_stage_xref_contest
FOREIGN KEY (contest_id)
REFERENCES contest (contest_id);

ALTER TABLE contest_stage_xref
ADD CONSTRAINT fk_contest_stage_xref_stage
FOREIGN KEY (stage_id)
REFERENCES stage (stage_id);

ALTER TABLE contest_season_xref
ADD CONSTRAINT fk_contest_season_xref_contest
FOREIGN KEY (contest_id)
REFERENCES contest (contest_id);

ALTER TABLE contest_season_xref
ADD CONSTRAINT fk_contest_season_xref_season
FOREIGN KEY (season_id)
REFERENCES season (season_id);

ALTER TABLE streak
ADD CONSTRAINT streak_start_project_fk
FOREIGN KEY (start_project_id)
REFERENCES project (project_id);

ALTER TABLE streak
ADD CONSTRAINT streak_end_project_fk
FOREIGN KEY (end_project_id)
REFERENCES project (project_id);

ALTER TABLE streak
ADD CONSTRAINT streak_typelu_fk
FOREIGN KEY (streak_type_id)
REFERENCES streak_type_lu (streak_type_id);

ALTER TABLE contest_result
ADD CONSTRAINT contest_result_contest_id_fk
FOREIGN KEY (contest_id)
REFERENCES contest (contest_id);

ALTER TABLE scorecard_question
ADD CONSTRAINT question_template_fkey
FOREIGN KEY (scorecard_template_id)
REFERENCES scorecard_template (scorecard_template_id);

ALTER TABLE user_rating
ADD CONSTRAINT userrating_project_fk
FOREIGN KEY (last_rated_project_id)
REFERENCES project (project_id);

ALTER TABLE dr_points
ADD CONSTRAINT dr_points_fkindex1
FOREIGN KEY (track_id)
REFERENCES track (track_id);

ALTER TABLE track_contest
ADD CONSTRAINT track_contest_fkindex1
FOREIGN KEY (track_id)
REFERENCES track (track_id);

ALTER TABLE track_contest_results
ADD CONSTRAINT track_contest_results_fkindex1
FOREIGN KEY (track_contest_id)
REFERENCES track_contest (track_contest_id);

ALTER TABLE project_spec_review_xref
ADD CONSTRAINT project_spec_rv_x_project_fk
FOREIGN KEY (project_id)
REFERENCES project (project_id);

ALTER TABLE project
ADD CONSTRAINT project_client_project_dim_id_fk
FOREIGN KEY (client_project_id)
REFERENCES client_project_dim (client_project_id);

ALTER TABLE weekly_contest_stats
ADD CONSTRAINT weekly_contest_status_client_project_dim_id_fk
FOREIGN KEY (client_project_id)
REFERENCES client_project_dim (client_project_id);

ALTER TABLE monthly_contest_stats
ADD CONSTRAINT monthly_contest_status_client_project_dim_id_fk
FOREIGN KEY (client_project_id)
REFERENCES client_project_dim (client_project_id);

ALTER TABLE user_achievement_rule
ADD CONSTRAINT fk_user_achivement_rule_user_achievement_type_lu
FOREIGN KEY (user_achievement_type_id)
REFERENCES user_achievement_type_lu (user_achievement_type_id);

ALTER TABLE user_achievement_xref
ADD CONSTRAINT fk_user_achievement_xref_user_achievement_rule
FOREIGN KEY (user_achievement_rule_id)
REFERENCES user_achievement_rule (user_achievement_rule_id);

ALTER TABLE jira_issue
ADD CONSTRAINT unique_jira_issue_ticket_id
UNIQUE(ticket_id);
