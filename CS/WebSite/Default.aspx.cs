using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using System.Drawing;
using System.Collections;
using System.Data;

public partial class _Default : System.Web.UI.Page {
    protected void masterGrid_DataBinding (object sender, EventArgs e) {
        DoSelect(masterDataSource.DataFile);
    }
    private void DoSelect (string connectionString) {
        DataView selectResult = new DataView();
        string selectCommand = "select distinct [CategoryID] from [Products]";
        using (AccessDataSource ds = new AccessDataSource(connectionString, selectCommand)) {
            selectResult = (DataView)ds.Select(DataSourceSelectArguments.Empty);
        }
        ArrayList result = new ArrayList();
        foreach (DataRow row in selectResult.Table.Rows)
            result.Add(row["CategoryID"]);
        Session["SelectResult"] = result;
    }
    protected void masterGrid_DetailRowGetButtonVisibility
    (object sender, ASPxGridViewDetailRowButtonEventArgs e) {
        if (!((ArrayList)Session["SelectResult"]).Contains(e.KeyValue))
            e.ButtonState = GridViewDetailRowButtonState.Hidden;
    }
    protected void detailGrid_BeforePerformDataSelect (object sender, EventArgs e) {
        Session["CategoryID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
}
