<?php
if (!isset($_SESSION['ADMIN_USERID'])) {
  redirect(web_root . "admin/index.php");
}

$autonum = new Autonumber();
$res = $autonum->set_autonumber('SKU');

?>
<!-- // SELECT `SKU`, `ProductName`, `Description`, `OriginalPrice`, `MarkupPrice`, `Unit`, `SuplierID` FROM `tblproduct` WHERE 1 -->

<div class="center wow fadeInDown">
  <h2 class="page-header">Add New</h2>
</div>

<form class="form-horizontal span6  wow fadeInDown" action="controller.php?action=add" method="POST" enctype="multipart/form-data" autocomplete="off" onsubmit="return validate_fields()">

  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label" for="SKU">ServiceID:</label>

      <div class="col-md-8">

        <input class="form-control input-sm" id="SKU" name="SKU" placeholder="ServiceID" type="text" value="<?php echo $res->AUTO; ?>" readonly="true">
      </div>
    </div>
  </div>

  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label" for="ToothNumber">Tooth Number:</label>

      <div class="col-md-8">

        <input class="form-control input-sm" id="ToothNumber" name="ToothNumber" placeholder="Tooth Number" type="number" value="" min="1" max="32">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label">Surface:</label>
      <div class="col-md-8">
        <label class="checkbox-inline">
          <input type="checkbox" name="surfaces[]" value="L"> Lingual
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="surfaces[]" value="F"> Facial
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="surfaces[]" value="D"> Distal
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="surfaces[]" value="M"> Mesial
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="surfaces[]" value="T"> Top
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="surfaces[]" value="R"> Root
        </label>
      </div>
    </div>
  </div>

  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label" for="Services">Service:</label>

      <div class="col-md-8">

        <input class="form-control input-sm" id="Services" name="Services" placeholder="Service Name" type="text" value="">
      </div>
    </div>
  </div>

  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label" for="Description">Description:</label>

      <div class="col-md-8">
        <textarea class="form-control input-sm" id="Description" name="Description" placeholder="Description"></textarea>
      </div>
    </div>
  </div>

  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label" for="OriginalPrice">Price:</label>

      <div class="col-md-8">

        <input class="form-control input-sm" id="OriginalPrice" name="OriginalPrice" placeholder="Cost">
      </div>
    </div>
  </div>
  <div class="col-md-12 teeth-chart">


    <?php
    for ($i = 1; $i < 17; $i++) {
      echo '<a href="#1"><span style="font-size: 50px" class="icon-iconfinder_Dental_-_Tooth_-_Dentist_-_Dentistry_01_2185089"><span class="path1"></span><span class="path2"></span><span class="path3"></span></span><span class="number" style="color:blue">' . $i . '</span>	</a>';
    }
    echo '<br/>';
    for ($i = 17; $i < 33; $i++) {
      echo '<a href="#1"><span style="font-size: 50px" class="icon-iconfinder_Dental_-_Tooth_-_Dentist_-_Dentistry_01_2185089"><span class="path1"></span><span class="path2"></span><span class="path3"></span></span><span class="number" style="color:blue">' . $i . '</span>	</a>';
    }
    ?>

    <br />
    <?php

    ?>

  </div>
  <div class="form-group">
    <div class="col-md-8">
      <label class="col-md-4 control-label" for="idno"></label>

      <div class="col-md-8">
        <button class="btn btn-primary btn-md" name="save" type="submit"><span class="fa fa-save fw-fa"></span> Save</button>
        <a href="index.php" class="btn btn-md btn-default"><span class="glyphicon glyphicon-arrow-left"></span>&nbsp;<strong>Back</strong></a>

      </div>
    </div>
  </div>


</form>