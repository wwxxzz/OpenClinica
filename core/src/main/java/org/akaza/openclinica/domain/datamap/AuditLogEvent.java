// default package
package org.akaza.openclinica.domain.datamap;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.akaza.openclinica.domain.DataMapDomainObject;
import org.akaza.openclinica.domain.user.UserAccount;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * AuditLogEvent generated by hbm2java
 */
@Entity
@Table(name = "audit_log_event")
@GenericGenerator(name = "id-generator", strategy = "native", parameters = { @Parameter(name = "sequence", value = "audit_log_event_audit_id_seq") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class AuditLogEvent extends DataMapDomainObject implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int auditId;
	private Date auditDate;
	private String auditTable;
	private Integer userId;
	private Integer entityId;
	private String entityName;
	private String reasonForChange;
	//private Integer auditLogEventTypeId;
	private String oldValue;
	private String newValue;
	private Integer eventCrfId;
	private Integer studyEventId;
	private Integer eventCrfVersionId;
	private UserAccount userAccount;
	
	private AuditLogEventType auditLogEventType;
	
	public AuditLogEvent() {
	}

	public AuditLogEvent(int auditId, Date auditDate, String auditTable) {
		this.auditId = auditId;
		this.auditDate = auditDate;
		this.auditTable = auditTable;
	}

	public AuditLogEvent(int auditId, Date auditDate, String auditTable,
			Integer userId, Integer entityId, String entityName,
			String reasonForChange, /*Integer auditLogEventTypeId,*/
			String oldValue, String newValue, Integer eventCrfId,
			Integer studyEventId, Integer eventCrfVersionId) {
		this.auditId = auditId;
		this.auditDate = auditDate;
		this.auditTable = auditTable;
		this.userId = userId;
		this.entityId = entityId;
		this.entityName = entityName;
		this.reasonForChange = reasonForChange;
	//	this.auditLogEventTypeId = auditLogEventTypeId;
		this.oldValue = oldValue;
		this.newValue = newValue;
		this.eventCrfId = eventCrfId;
		this.studyEventId = studyEventId;
		this.eventCrfVersionId = eventCrfVersionId;
	}

	@Id
	@Column(name = "audit_id", unique = true, nullable = false)
	public int getAuditId() {
		return this.auditId;
	}

	public void setAuditId(int auditId) {
		this.auditId = auditId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "audit_date", nullable = false, length = 8)
	public Date getAuditDate() {
		return this.auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}

	@Column(name = "audit_table", nullable = false, length = 500)
	public String getAuditTable() {
		return this.auditTable;
	}

	public void setAuditTable(String auditTable) {
		this.auditTable = auditTable;
	}

	/*@Column(name = "user_id")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}*/

	@Column(name = "entity_id")
	public Integer getEntityId() {
		return this.entityId;
	}

	public void setEntityId(Integer entityId) {
		this.entityId = entityId;
	}

	@Column(name = "entity_name", length = 500)
	public String getEntityName() {
		return this.entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	@Column(name = "reason_for_change", length = 1000)
	public String getReasonForChange() {
		return this.reasonForChange;
	}

	public void setReasonForChange(String reasonForChange) {
		this.reasonForChange = reasonForChange;
	}

	/*@Column(name = "audit_log_event_type_id")
	public Integer getAuditLogEventTypeId() {
		return this.auditLogEventTypeId;
	}

	public void setAuditLogEventTypeId(Integer auditLogEventTypeId) {
		this.auditLogEventTypeId = auditLogEventTypeId;
	}*/

	@Column(name = "old_value", length = 4000)
	public String getOldValue() {
		return this.oldValue;
	}

	public void setOldValue(String oldValue) {
		this.oldValue = oldValue;
	}

	@Column(name = "new_value", length = 4000)
	public String getNewValue() {
		return this.newValue;
	}

	public void setNewValue(String newValue) {
		this.newValue = newValue;
	}

	@Column(name = "event_crf_id")
	public Integer getEventCrfId() {
		return this.eventCrfId;
	}

	public void setEventCrfId(Integer eventCrfId) {
		this.eventCrfId = eventCrfId;
	}

	@Column(name = "study_event_id")
	public Integer getStudyEventId() {
		return this.studyEventId;
	}

	public void setStudyEventId(Integer studyEventId) {
		this.studyEventId = studyEventId;
	}

	@Column(name = "event_crf_version_id")
	public Integer getEventCrfVersionId() {
		return this.eventCrfVersionId;
	}

	public void setEventCrfVersionId(Integer eventCrfVersionId) {
		this.eventCrfVersionId = eventCrfVersionId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "audit_log_event_type_id", nullable = false)
	public AuditLogEventType getAuditLogEventType() {
		return auditLogEventType;
	}

	public void setAuditLogEventType(AuditLogEventType auditLogEventType) {
		this.auditLogEventType = auditLogEventType;
	}

	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public UserAccount getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(UserAccount userAccount) {
		this.userAccount = userAccount;
	}

}
