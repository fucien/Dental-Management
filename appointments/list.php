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

    <div class="filter-form">
      <select class="form-control select2" style="width: 30%;" id="patients" REQUIRED>
        <option value="">Select Patients</option>
        <?php
        $mydb->setQuery("SELECT * FROM `tblpatients`");
        $cur = $mydb->loadResultList();
        foreach ($cur as $result) {
          echo '<option>' . $result->Fname . ', ' . $result->Mname . ' ' . $result->Lname . '<option>';
        }
        ?>
      </select>
      <select class="form-control select2" style="width: 30%" id="dentists" name="dentists" required>
        <option value="">Select Dentists</option>
        <?php
        $mydb->setQuery("SELECT * FROM `tblusers` WHERE Role = 'Dentist'");
        $dentists = $mydb->loadResultList();
        foreach ($dentists as $dentist) {
          echo '<option value="' . $dentist->FullName . '">' . $dentist->FullName . '</option>';
        }
        ?>
      </select>

      <input class="form-control" type="date" name="filter_date" style="width: 30%">
    </div>

    <h1 class="page-header"><a href="" class="btn btn-primary btn-md  "> <i class="fa fa-plus-circle fw-fa"></i>Filter</a> </h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<div class="table-responsive">
  <form class="wow fadeInDownaction" action="controller.php?action=delete" Method="POST">
    <table id="dash-table" class="table table-striped table-bordered table-hover mytbl" style="font-size:12px" cellspacing="0">
      <thead>
        <tr>
          <th>AppoinmentID</th>
          <th>Patient Name</th>
          <th>Dentist Name</th>
          <th>Services</th>
          <th>Date</th>
          <th>Time</th>

          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php
        $sql = "SELECT * FROM tblappointments INNER JOIN tblpatients ON tblpatients.PatientID = tblappointments.PatientID INNER JOIN tblusers ON tblusers.UserID = tblappointments.UserID INNER JOIN tblservices ON tblservices.ServiceID = tblappointments.ServiceID;";

        $mydb->setQuery($sql);
        $cur = $mydb->loadResultList();

        foreach ($cur as $result) {
          echo '<tr>';
          echo '<td>' . $result->AppoinmentID . '</td>';
          echo '<td>' . $result->Fname . ' ' . $result->Mname . ' ' . $result->Lname . '</td>';
          echo '<td>' . $result->FullName . '</td>';
          echo '<td>' . $result->Services . '</td>';
          echo '<td>' . $result->A_Date . '</td>';
          echo '<td>' . $result->A_Time . '</td>';

          echo '<td align="center">
                        <a title="Edit" href="index.php?view=edit&id=' . $result->AppoinmentID . '" class="btn btn-info btn-md"><span class="fa fa-edit fw-fa"></span>Edit</a>
                        <a title="Remove" href="controller.php?action=delete&id=' . $result->AppoinmentID . '" class="btn btn-danger btn-md">
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