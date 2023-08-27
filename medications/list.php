<?php
if (!isset($_SESSION['ADMIN_USERID'])) {
	redirect(web_root . "login.php");
}

?>
<style type="text/css">
	.table {
		white-space: nowrap;
	}
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header"><a href="index.php?view=add" class="btn btn-primary btn-md  "> <i class="fa fa-plus-circle fw-fa"></i> Add New Medication</a> </h1>
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="table-responsive">
	<form class="wow fadeInDownaction" action="controller.php?action=delete" Method="POST">
		<table id="dash-table" class="table table-striped table-bordered table-hover mytbl" style="font-size:12px" cellspacing="0">
			<thead>
				<tr>
					<th>Medication ID</th>
					<th>Name</th>
					<th>Medication Name</th>
					<th>Dosage</th>
					<th>Level</th>
					<th>Indication</th>

					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<?php
				$sql = "SELECT * FROM medications INNER JOIN tblpatients ON tblpatients.PatientID = medications.PatientID;";

				$mydb->setQuery($sql);
				$cur = $mydb->loadResultList();

				foreach ($cur as $result) {
					echo '<tr>';
					echo '<td>' . $result->MedicationID . '</td>';
					echo '<td>' . $result->Fname . ' ' . $result->Mname . ' ' . $result->Lname . '</td>';
					echo '<td>' . $result->MedicationName . '</td>';
					echo '<td>' . $result->Dosage . '</td>';
					echo '<td>' . $result->Level . '</td>';
					echo '<td>' . $result->Indication . '</td>';

					echo '<td align="center">
                        <a title="Edit" href="index.php?view=edit&id=' . $result->MedicationID . '" class="btn btn-info btn-md"><span class="fa fa-edit fw-fa"></span>Edit</a>
                        <a title="Remove" href="controller.php?action=delete&id=' . $result->MedicationID . '" class="btn btn-danger btn-md">
                        <span class="fa fa-trash-o fw-fa"></span>Remove</a>
                      </td>';
					echo '</tr>';
					
				}
				?>
			</tbody>
		</table>
	</form>
</div>

</form>