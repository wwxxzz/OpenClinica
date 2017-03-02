package org.akaza.openclinica.domain.datamap;
// Generated Jul 31, 2013 2:03:33 PM by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.akaza.openclinica.domain.DataMapDomainObject;
import org.akaza.openclinica.domain.Status;
import org.akaza.openclinica.domain.user.UserAccount;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * EventCrf generated by hbm2java
 */
@Entity
@Table(name = "event_crf")
@GenericGenerator(name = "id-generator", strategy = "native", parameters = { @Parameter(name = "sequence", value = "event_crf_event_crf_id_seq") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)

public class EventCrf  extends DataMapDomainObject {

	private int eventCrfId;
	private UserAccount userAccount;
	private CompletionStatus completionStatus;
	private StudyEvent studyEvent;
	private StudySubject studySubject;
	private CrfVersion crfVersion;
	private Integer statusId;
	private Date dateInterviewed;
	private String interviewerName;
	private String annotations;
	private Date dateCompleted;
	private Integer validatorId;
	private Date dateValidate;
	private Date dateValidateCompleted;
	private String validatorAnnotations;
	private String validateString;
	private Date dateCreated;
	private Date dateUpdated;
	private Integer updateId;
	private Boolean electronicSignatureStatus;
	private boolean sdvStatus;
	private Integer oldStatusId;
	private Integer sdvUpdateId;
	private List<DnEventCrfMap> dnEventCrfMaps;
	private List<ItemData> itemDatas ;

	public EventCrf() {
	}

	public EventCrf(int eventCrfId, boolean sdvStatus) {
		this.eventCrfId = eventCrfId;
		this.sdvStatus = sdvStatus;
	}

	public EventCrf(int eventCrfId, UserAccount userAccount,
			CompletionStatus completionStatus, StudyEvent studyEvent,
			StudySubject studySubject, CrfVersion crfVersion, Integer statusId,
			Date dateInterviewed, String interviewerName, String annotations,
			Date dateCompleted, Integer validatorId, Date dateValidate,
			Date dateValidateCompleted, String validatorAnnotations,
			String validateString, Date dateCreated, Date dateUpdated,
			Integer updateId, Boolean electronicSignatureStatus,
			boolean sdvStatus, Integer oldStatusId, Integer sdvUpdateId,
			List<DnEventCrfMap> dnEventCrfMaps, List<ItemData> itemDatas) {
		this.eventCrfId = eventCrfId;
		this.userAccount = userAccount;
		this.completionStatus = completionStatus;
		this.studyEvent = studyEvent;
		this.studySubject = studySubject;
		this.crfVersion = crfVersion;
		this.statusId = statusId;
		this.dateInterviewed = dateInterviewed;
		this.interviewerName = interviewerName;
		this.annotations = annotations;
		this.dateCompleted = dateCompleted;
		this.validatorId = validatorId;
		this.dateValidate = dateValidate;
		this.dateValidateCompleted = dateValidateCompleted;
		this.validatorAnnotations = validatorAnnotations;
		this.validateString = validateString;
		this.dateCreated = dateCreated;
		this.dateUpdated = dateUpdated;
		this.updateId = updateId;
		this.electronicSignatureStatus = electronicSignatureStatus;
		this.sdvStatus = sdvStatus;
		this.oldStatusId = oldStatusId;
		this.sdvUpdateId = sdvUpdateId;
		this.dnEventCrfMaps = dnEventCrfMaps;
		this.itemDatas = itemDatas;
	}

	@Id
	@Column(name = "event_crf_id", unique = true, nullable = false)
	@GeneratedValue(generator = "id-generator")

	public int getEventCrfId() {
		return this.eventCrfId;
	}

	public void setEventCrfId(int eventCrfId) {
		this.eventCrfId = eventCrfId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "owner_id")
	public UserAccount getUserAccount() {
		return this.userAccount;
	}

	public void setUserAccount(UserAccount userAccount) {
		this.userAccount = userAccount;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "completion_status_id")
	public CompletionStatus getCompletionStatus() {
		return this.completionStatus;
	}

	public void setCompletionStatus(CompletionStatus completionStatus) {
		this.completionStatus = completionStatus;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "study_event_id")
	public StudyEvent getStudyEvent() {
		return this.studyEvent;
	}

	public void setStudyEvent(StudyEvent studyEvent) {
		this.studyEvent = studyEvent;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "study_subject_id")
	public StudySubject getStudySubject() {
		return this.studySubject;
	}

	public void setStudySubject(StudySubject studySubject) {
		this.studySubject = studySubject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "crf_version_id")
	public CrfVersion getCrfVersion() {
		return this.crfVersion;
	}

	public void setCrfVersion(CrfVersion crfVersion) {
		this.crfVersion = crfVersion;
	}

    @Column(name = "status_id")
    public Integer getStatusId() {
        if (statusId != null) {
            return statusId;
        } else
            return Status.AVAILABLE.getCode();
    }
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "date_interviewed", length = 4)
	public Date getDateInterviewed() {
		return this.dateInterviewed;
	}

	public void setDateInterviewed(Date dateInterviewed) {
		this.dateInterviewed = dateInterviewed;
	}

	@Column(name = "interviewer_name")
	public String getInterviewerName() {
		return this.interviewerName;
	}

	public void setInterviewerName(String interviewerName) {
		this.interviewerName = interviewerName;
	}

	@Column(name = "annotations", length = 4000)
	public String getAnnotations() {
		return this.annotations;
	}

	public void setAnnotations(String annotations) {
		this.annotations = annotations;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_completed", length = 8)
	public Date getDateCompleted() {
		return this.dateCompleted;
	}

	public void setDateCompleted(Date dateCompleted) {
		this.dateCompleted = dateCompleted;
	}

	@Column(name = "validator_id")
	public Integer getValidatorId() {
		return this.validatorId;
	}

	public void setValidatorId(Integer validatorId) {
		this.validatorId = validatorId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "date_validate", length = 4)
	public Date getDateValidate() {
		return this.dateValidate;
	}

	public void setDateValidate(Date dateValidate) {
		this.dateValidate = dateValidate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_validate_completed", length = 8)
	public Date getDateValidateCompleted() {
		return this.dateValidateCompleted;
	}

	public void setDateValidateCompleted(Date dateValidateCompleted) {
		this.dateValidateCompleted = dateValidateCompleted;
	}

	@Column(name = "validator_annotations", length = 4000)
	public String getValidatorAnnotations() {
		return this.validatorAnnotations;
	}

	public void setValidatorAnnotations(String validatorAnnotations) {
		this.validatorAnnotations = validatorAnnotations;
	}

	@Column(name = "validate_string", length = 256)
	public String getValidateString() {
		return this.validateString;
	}

	public void setValidateString(String validateString) {
		this.validateString = validateString;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_created", length = 8)
	public Date getDateCreated() {
		return this.dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date_updated", length = 8)
	public Date getDateUpdated() {
		return this.dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated) {
		this.dateUpdated = dateUpdated;
	}

	@Column(name = "update_id")
	public Integer getUpdateId() {
		return this.updateId;
	}

	public void setUpdateId(Integer updateId) {
		this.updateId = updateId;
	}

	@Column(name = "electronic_signature_status")
	public Boolean getElectronicSignatureStatus() {
		return this.electronicSignatureStatus;
	}

	public void setElectronicSignatureStatus(Boolean electronicSignatureStatus) {
		this.electronicSignatureStatus = electronicSignatureStatus;
	}

	@Column(name = "sdv_status", nullable = false)
	public boolean isSdvStatus() {
		return this.sdvStatus;
	}

	public void setSdvStatus(boolean sdvStatus) {
		this.sdvStatus = sdvStatus;
	}

	@Column(name = "old_status_id")
	public Integer getOldStatusId() {
		return this.oldStatusId;
	}

	public void setOldStatusId(Integer oldStatusId) {
		this.oldStatusId = oldStatusId;
	}

	@Column(name = "sdv_update_id")
	public Integer getSdvUpdateId() {
		return this.sdvUpdateId;
	}

	public void setSdvUpdateId(Integer sdvUpdateId) {
		this.sdvUpdateId = sdvUpdateId;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "eventCrf")
	@OrderBy("discrepancyNote")
	public List<DnEventCrfMap> getDnEventCrfMaps() {
		return this.dnEventCrfMaps;
	}

	public void setDnEventCrfMaps(List<DnEventCrfMap> dnEventCrfMaps) {
		this.dnEventCrfMaps = dnEventCrfMaps;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "eventCrf")
	public List<ItemData> getItemDatas() {
		return this.itemDatas;
	}

	public void setItemDatas(List<ItemData> itemDatas) {
		this.itemDatas = itemDatas;
	}



}
