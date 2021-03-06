package application.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;

import application.data.HandleItemInf;
import lombok.Data;
import lombok.ToString;

@Entity
@Data
@ToString(exclude = "character")
public class Inventory implements HandleItemInf, Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Long id;

	@OneToOne
	@MapsId
	@JoinColumn(name = "character_id")
	@JsonBackReference
	private Character character;

	public void copyFields(final Inventory item) {
		this.id = item.id;
		this.character = item.character;
	}

	@Override
	public String methodGetKey() {
		// TODO Auto-generated method stub
		return "getId";
	}

	@Override
	public HandleItemInf updateItem(final HandleItemInf pNewItem) {
		Inventory newItem = (Inventory) pNewItem;
		this.copyFields(newItem);
		return this;
	}

}
