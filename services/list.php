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
		<h1 class="page-header"><a href="index.php?view=add" class="btn btn-primary btn-md  "> <i class="fa fa-plus-circle fw-fa"></i> Add New Service</a> </h1>
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="table-responsive">
	<form class="wow fadeInDownaction" action="controller.php?action=delete" Method="POST">
		<table id="dash-table" class="table table-striped table-bordered table-hover mytbl" style="font-size:12px" cellspacing="0">
			<thead>
				<tr>
					<th>Services ID</th>
					<th>Tooth Number</th>
					<th>Surfaces</th>
					<th>Services</th>
					<th>Description</th>
					<th>Price</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<?php
				$sql = "SELECT s.*, GROUP_CONCAT(ss.Surface) AS Surfaces
                FROM tblservices s
                LEFT JOIN tblservice_surfaces ss ON s.ServiceID = ss.ServiceID
                GROUP BY s.ServiceID";

				$mydb->setQuery($sql);
				$cur = $mydb->loadResultList();

				foreach ($cur as $result) {
					echo '<tr>';
					echo '<td>' . $result->ServiceID . '</td>';
					echo '<td>' . $result->ToothNumber . '</td>';
					echo '<td>' . $result->Surfaces . '</td>';
					echo '<td>' . $result->Services . '</td>';
					echo '<td>' . $result->Description . '</a></td>';
					echo '<td>' . number_format($result->OriginalPrice, 2) . ' ' . $setDefault->default_currency() . '</td>';
					echo '<td align="center">
                        <a title="Edit" href="index.php?view=edit&id=' . $result->ServiceID . '" class="btn btn-info btn-md"><span class="fa fa-edit fw-fa"></span>Edit</a>
                        <a title="Remove" href="controller.php?action=delete&id=' . $result->ServiceID . '" class="btn btn-danger btn-md">
                        <span class="fa fa-trash-o fw-fa"></span>Remove</a>
                      </td>';
					echo '</tr>';
				}
				?>
			</tbody>
		</table>


</div>
</form>