Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.Data
Imports System.Drawing
Imports System.Collections
Imports System.Data

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub masterGrid_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
		DoSelect(masterDataSource.DataFile)
	End Sub
	Private Sub DoSelect(ByVal connectionString As String)
		Dim selectResult As New DataView()
		Dim selectCommand As String = "select distinct [CategoryID] from [Products]"
		Using ds As New AccessDataSource(connectionString, selectCommand)
			selectResult = CType(ds.Select(DataSourceSelectArguments.Empty), DataView)
		End Using
		Dim result As New ArrayList()
		For Each row As DataRow In selectResult.Table.Rows
			result.Add(row("CategoryID"))
		Next row
		Session("SelectResult") = result
	End Sub
	Protected Sub masterGrid_DetailRowGetButtonVisibility(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowButtonEventArgs)
		If Not(CType(Session("SelectResult"), ArrayList)).Contains(e.KeyValue) Then
			e.ButtonState = GridViewDetailRowButtonState.Hidden
		End If
	End Sub
	Protected Sub detailGrid_BeforePerformDataSelect(ByVal sender As Object, ByVal e As EventArgs)
		Session("CategoryID") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()
	End Sub
End Class
