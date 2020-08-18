<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>How to hide the detail button if the detail grid is empty</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <br />
    </div>
    <dx:ASPxGridView ID="mainGrid" runat="server" AutoGenerateColumns="False" DataSourceID="masterDataSource"
        KeyFieldName="CategoryID" OnDataBinding="masterGrid_DataBinding" OnDetailRowGetButtonVisibility="masterGrid_DetailRowGetButtonVisibility">
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="detailGrid" runat="server" AutoGenerateColumns="False" DataSourceID="dsDetail"
                    KeyFieldName="ProductID" OnBeforePerformDataSelect="detailGrid_BeforePerformDataSelect"
                    Width="100%">
                    <Styles>
                        <DetailRow HorizontalAlign="Justify">
                        </DetailRow>
                    </Styles>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
            </DetailRow>
        </Templates>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="0">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsDetail ShowDetailRow="True" />
    </dx:ASPxGridView>
    <asp:AccessDataSource ID="dsDetail" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Products]  WHERE ([CategoryID] = ?)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="CategoryID" Name="CategoryID" SessionField="CategoryID"
                Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="masterDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT * FROM [Categories]"></asp:AccessDataSource>
    </form>
</body>
</html>
