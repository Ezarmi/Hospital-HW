using Hospital.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Helpers;
using System.Web.Hosting;
using System.Web.Mvc;

namespace hardworker.Controllers
{
    public class PayController : Controller
    {
        hdata context = new hdata();
        private string GatewaySend = "https://panel.aqayepardakht.ir/api/create";
        private string GatewayResult = "https://panel.aqayepardakht.ir/api/verify";

        private string pin = "aqayepardakht";


        private new string Redirect = "https://localhost:44360/pay/CallBack";



        [HttpPost]
        [ActionName("submit")]
        [ValidateAntiForgeryToken]
        public async System.Threading.Tasks.Task<ActionResult> SubmitAsync(string vn, string pid, string amount)
        {


            try
            {



                using (var client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                        { "pin", pin },
                        { "amount", amount },
                        { "callback", Redirect },
                        { "invoice_id", vn },
                        { "description", pid }


                    };

                    var content = new FormUrlEncodedContent(values);

                    var response = await client.PostAsync(GatewaySend, content);
                    string responseString = await response.Content.ReadAsStringAsync();
                  
                    if (responseString.Length>3)
                    {
                        return Json(new { message = "https://panel.aqayepardakht.ir/startpay/" + responseString, success = true, JsonRequestBehavior.AllowGet });

                    }
                    else
                    {
                        //return View();
                        int error = int.Parse(responseString);
                        return Json(new { error = error, success = false, JsonRequestBehavior.AllowGet });
                    }
                }






            }
            catch (Exception ex)
            {
                //return View();
                return Json(new { message = ex.Message, success = true, JsonRequestBehavior.AllowGet });
            }
            //return View();
        }

        //string Date2Persian(DateTime date)
        //{
        //    PersianCalendar p = new PersianCalendar();
        //    return $"{p.GetYear(date)}/{p.GetMonth(date):D2}/{p.GetDayOfMonth(date):D2} - {date.Hour:D2}:{date.Minute:D2}";
        //}

        //[HttpPost]
        [AllowAnonymous]
        [ActionName("CallBack")]
        public async System.Threading.Tasks.Task<ActionResult> CallBackAsync()
        {
            if (!string.IsNullOrEmpty(Request.Form["transId"]))
            {
                string amount = "10000";

                try
                {
                    using (var client = new HttpClient())
                    {
                        var values = new Dictionary<string, string>
                        {
                            { "pin", pin },
                            { "amount", amount },

                            { "transid", Request.Form["transid"].ToString() },
                        };





                        

                        



                        var content = new FormUrlEncodedContent(values);

                        var response = await client.PostAsync(GatewayResult, content);
                        var responseString = await response.Content.ReadAsStringAsync();

                        if (responseString == "1")
                        {




                            try
                            {



                                if (context.tbl_Transfer.Where(x => x.transid == Request.Form["transid"].ToString()).Any())
                                {
                                    ViewBag.message = "شماره تراکنش تقلبی است";
                                }
                                else
                                {
                                    tbl_Transfer nt = new tbl_Transfer();
                                   //nt.






                                   // var useradd = context.tbl_Users.Where(x => x.pkUserID == ret.factorNumber).SingleOrDefault();
                                   // useradd.AcountBallance += (ret.amount / 10);

                                   // tbl_Transfer table2 = new tbl_Transfer();
                                   // table2.fkUserID = ret.factorNumber;
                                   // table2.fkTranferTypeID = 3001;
                                   // table2.TransferDate = DateTime.Now;
                                   // table2.TransferRef = ret.transId;
                                   // table2.Amount = ret.amount / 10;
                                   // table2.nowvalue = useradd.AcountBallance;
                                   // context.tbl_Transfer.Add(table2);

                                   // context.SaveChanges();

                                   // ViewBag.Success = "1";
                                   // ViewBag.transId = ret.transId;
                                   // ViewBag.cardNumber = ret.cardNumber;
                                   // //ViewBag.traceNumber = ret["traceNumber"].ToString();
                                   // ViewBag.message = "پرداخت با موفقیت انجام شد";
                                   // ViewBag.Date = Date2Persian(DateTime.Now);
                                   // ViewBag.ID = ret.factorNumber;


                                }


                            }
                            catch (Exception ex)
                            {
                            }
                        }
                        else
                        {
                            ViewBag.Success = "0";
                            //ViewBag.message = ViewBag.message = ret.errorCode + " " + ret.errorMessage;

                        }
                    }
                }
                catch (Exception ex)
                {
                    ViewBag.Success = "0";
                    ViewBag.message = ex.Message;


                }
            }
            else
            {
                ViewBag.message = new string[] { "پرداخت با موفقیت انجام نشد" };
            }
            return View();
        }
        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Error(string a)
        {
            ViewBag.Message = a;
            return View();
        }




        public ActionResult Invoice(string invoiceCode)
        {
            if (string.IsNullOrEmpty(invoiceCode))
                ViewBag.ShowImage = "0";
            else
            {
                ViewBag.ShowImage = "1";
                ViewBag.InvoiceCode = invoiceCode.Trim();
            }
            return View();
        }
        [HttpPost]
        public ActionResult SearchFile(string invoiceCode)
        {
            if (!Request.IsAjaxRequest())
                return Json(false);
            var relativePath = "~/UploadedImages/" + invoiceCode + ".jpg";
            var absolutePath = HttpContext.Server.MapPath(relativePath);
            return Json(System.IO.File.Exists(absolutePath));
        }
    }
}
