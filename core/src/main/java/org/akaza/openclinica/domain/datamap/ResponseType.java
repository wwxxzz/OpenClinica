package org.akaza.openclinica.domain.datamap;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.akaza.openclinica.domain.DataMapDomainObject;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * ResponseType generated by hbm2java
 */
@Entity
@Table(name = "response_type")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ResponseType  extends DataMapDomainObject {

	private int responseTypeId;
	private String name;
	private String description;
	private List<ResponseSet> responseSets;

	public ResponseType() {
	}

	public ResponseType(int responseTypeId) {
		this.responseTypeId = responseTypeId;
	}

	public ResponseType(int responseTypeId, String name, String description,
			List<ResponseSet> responseSets) {
		this.responseTypeId = responseTypeId;
		this.name = name;
		this.description = description;
		this.responseSets = responseSets;
	}

	@Id
	@Column(name = "response_type_id", unique = true, nullable = false)
	public int getResponseTypeId() {
		return this.responseTypeId;
	}

	public void setResponseTypeId(int responseTypeId) {
		this.responseTypeId = responseTypeId;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", length = 1000)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "responseType")
	public List<ResponseSet> getResponseSets() {
		return this.responseSets;
	}

	public void setResponseSets(List<ResponseSet> responseSets) {
		this.responseSets = responseSets;
	}



}
