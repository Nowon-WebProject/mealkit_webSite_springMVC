<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 	<h3>단일 파일 업로드</h3> -->
<!-- 	<form action="singleFileUpload" method="post" enctype="multipart/form-data"> -->
<!-- 	    <table> -->
<!-- 	        <tr> -->
<!-- 	            <td>Select File</td> -->
<!-- 	            <td><input type="file" name="mediaFile"></td> -->
<!-- 	            <td><input type="file" name="mediaFile2"></td> -->
<!-- 	            <td> -->
<!-- 	                <button type="submit">Upload</button> -->
<!-- 	            </td> -->
<!-- 	        </tr> -->
<!-- 	    </table> -->
<!-- 	</form> -->

	<h1>Multi File Upload (다중 파일 업로드)</h1>
	<form action="singleFileUpload" method="post"
		enctype="multipart/form-data">
		<!-- multiple 속성추가 -->
		<input type="file" name="uploadfiles" placeholder="파일 선택" multiple /><br />
		<input type="file" name="uploadfiles" placeholder="파일 선택" multiple /><br />
		<input type="submit" value="upload">
	</form>

</body>
</html>