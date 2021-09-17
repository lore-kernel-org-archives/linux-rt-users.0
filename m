Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5031C43217
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9E961029
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 12:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbhIQMFH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:05:07 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:41630 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344042AbhIQMFE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 08:05:04 -0400
Received: from [100.112.197.4] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id DF/F8-30018-D1484416; Fri, 17 Sep 2021 12:03:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRWlGSWpSXmKPExsWi1/P8kK5si0u
  iwbuzEhbbrsxntLi8aw6bxemJPcwOzB7vzp1j9/i8SS6AKYo1My8pvyKBNePC/oksBb3yFWd+
  LWZvYFwl1cXIxSEksJJRouHALWYIZzOjxPYXSxi7GDk52AR0JI51TgKzRQTyJf6tWQ5mMws4S
  tze+5YJxBYW8JTo2n6JBaLGS6L3/h0o20pix7NV7CA2i4CqxIMn85hBbF6g3qf/dgPN4QBali
  mx7UogiMkpYCyxamUISAWjgKxE34kjbBCbxCU2PfvOCmJLCAhILNlznhnCFpV4+fgfK0irhIC
  GxNLLXhBhCYl9u3vZIGwDia1L97FA2PISs2fcgIpzSnT/eww1Xk/ixtQpULa2xLKFr6GOFJQ4
  OfMJywRGiVlIrpiFpGUWkpZZSFoWMLKsYrRIKspMzyjJTczM0TU0MNA1NDTSNbQ00zUyNNFLr
  NJN0kst1S1PLS7RNdRLLC/WK67MTc5J0ctLLdnECIzXlIIj13YwHnj9Qe8QoyQHk5Iob7aPS6
  IQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd7FTUA5waLU9NSKtMwcYOqASUtw8CiJ8L4ESfMWFyT
  mFmemQ6ROMRpzTHg5dxEzx8Gj8xYxC7Hk5eelSonzejYDlQqAlGaU5sENgqW0S4yyUsK8jAwM
  DEI8BalFuZklqPKvGMU5GJWEeYVAFvJk5pXA7XsFdAoT0ClH9juAnFKSiJCSamDK1tzmW77Ob
  9rSTdbMUbnnRQ+IK4RtNGr0vxXBvOLGep9Fy6+v7LYqqlDNclD8ttV++b3798wl8jjNZz2pXV
  Td/D/0qSDnTQ7f+UsX9c8TUte1cNHZ3XJgddM3oTdNsjNebWP49fiFaeP2I0JnDBrOTZyrcsV
  w5xKnqxxsXV9nCc7TYIvfK9+sUDnp3UGWWCcf7UO/7dS+2bwKS3/WfmX/q1cz/3fcnn/pd8KT
  sGNKpoU5HD/alhd8c5qvt1veVnKG0rL5S84XTSnSeGJiyGz9eu+EOevlVuzNCg5T2ypnsiJJR
  HLmY37NTdfso/0PLMry03x7tCRqyfpQqQ9cM4NeFfBOjV6tfeprtZXMpnRjJZbijERDLeai4k
  QAjBCa0eQDAAA=
X-Env-Sender: Walter.Stoll@duagon.com
X-Msg-Ref: server-12.tower-292.messagelabs.com!1631880220!302600!2
X-Originating-IP: [46.140.231.194]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5500 invoked from network); 17 Sep 2021 12:03:41 -0000
Received: from 46-140-231-194.static.upc.ch (HELO chdua14.duagon.ads) (46.140.231.194)
  by server-12.tower-292.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Sep 2021 12:03:41 -0000
Received: from chdua14.duagon.ads (172.16.90.14) by chdua14.duagon.ads
 (172.16.90.14) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 17 Sep
 2021 14:03:06 +0200
Received: from chdua14.duagon.ads ([fe80::4058:63e9:621d:cb5]) by
 chdua14.duagon.ads ([fe80::4058:63e9:621d:cb5%12]) with mapi id
 15.00.1497.023; Fri, 17 Sep 2021 14:03:06 +0200
From:   Walter Stoll <Walter.Stoll@duagon.com>
To:     John Ogness <john.ogness@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [BUG] kernel/printk: RT-adaption of kmsg_dump breaks mtdoops
Thread-Topic: [BUG] kernel/printk: RT-adaption of kmsg_dump breaks mtdoops
Thread-Index: AderrfiLv1XFN2b0R32Idkomc0vbm///8uoA///XVAA=
Date:   Fri, 17 Sep 2021 12:03:06 +0000
Message-ID: <1f9ea811ccbf44bbbff0bb5398a70bd5@chdua14.duagon.ads>
References: <c4b1a518b23c4507b3fc725cea005276@chdua14.duagon.ads>
 <87zgsb4eot.fsf@jogness.linutronix.de>
In-Reply-To: <87zgsb4eot.fsf@jogness.linutronix.de>
Accept-Language: en-US, de-CH
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-codetwo-clientsignature-inserted: true
x-codetwoprocessed: true
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.17.0.41]
x-loop: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> -----Ursprüngliche Nachricht-----
> Von: John Ogness <john.ogness@linutronix.de>
> Gesendet: Freitag, 17. September 2021 13:36
> An: Walter Stoll <Walter.Stoll@duagon.com>; linux-rt-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Betreff: Re: [BUG] kernel/printk: RT-adaption of kmsg_dump breaks mtdoops
> 
> Hello Walter,
> 
> On 2021-09-17, Walter Stoll <Walter.Stoll@duagon.com> wrote:
> > Effect observed
> > ---------------
> >
> > We want to store kernel oops logs on a NAND flash partition by means of the
> > MTD Oops/Panic console logger/driver. However, no log is generated.
> >
> > We observed the effect with kernel version v5.4.138-rt62. However, we think
> > that the most recent kernel exhibits the same behavior because the structure of
> > the sources in question (see below) did not change.
> 
> This problem does not exist in v5.10-rt. The kmsg_dump API was changed
> (later in mainline as well) to avoid this issue. For v5.10-rt the change
> was buried in the all-in-one commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v5.10-
> rt&id=9835363e31e75d3287a81c6fc1b22c5c2b43d277
> 
> And later. the API change for mainline (5.12):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9f3f02db98b
> be678a8e57fe9432b196174744a3
>

Ok, thanks a lot for your response. I was not aware of this.

> > Root cause
> > ----------
> >
> > Further investigations revealed, than the issue is due to the realtime adaption
> > of the kmsg_dump() function.
> >
> > Non realtime version of kmsg_dump():
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk
> .c?h=linux-5.4.y#n3149
> >
> > Realtime version of kmsg_dump():
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-
> rt.git/tree/kernel/printk/printk.c?h=v5.4-rt#n2904
> >
> > In our case, the the mtd_panic_write() function returns with error when the
> > kernel panics. As a result, no log is created. Call chain:
> > ... panic() -> kmsg_dump() -> mtdoops_do_dump() -> mtdoops_write()
> >     mtd_panic_write()
> >
> > Note that within the kmsg_dump() function, a locally create kmsg_dumper object
> > is passed to the dumper_local.dump(&dumper_local, reason) call. However the
> > callee mtdoops_do_dump() function expects this object being embedded in a
> > mtdoops_context object, see
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-
> rt.git/tree/drivers/mtd/mtdoops.c?h=v5.4-rt#n272
> >
> > This is obviously not the case, therefore the error. Note that this could even
> > led to a security issue.
> >
> >
> > Bug fix proposal
> > ----------------
> >
> > We fixed the bug locally by applying the patch below. Note that we did not
> > modify the kmsg_dump() function. Instead we modified the mtdoops_do_dump()
> > function which seems for us the cleaner way.
> 
> I agree that this is a better fix, rather than backporting the newer
> API. For mtdoops, the only function registering a dumper is
> mtdoops_notify_add() and it also directly references the global context
> with:
> 
> struct mtdoops_context *cxt = &oops_cxt;
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> > diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> > index 774970bfcf85..317ecf47fce8 100644
> > --- a/drivers/mtd/mtdoops.c
> > +++ b/drivers/mtd/mtdoops.c
> > @@ -269,8 +269,7 @@ static void find_next_position(struct mtdoops_context *cxt)
> >  static void mtdoops_do_dump(struct kmsg_dumper *dumper,
> >  			    enum kmsg_dump_reason reason)
> >  {
> > -	struct mtdoops_context *cxt = container_of(dumper,
> > -			struct mtdoops_context, dump);
> > +	struct mtdoops_context *cxt = &oops_cxt;
> >
> >  	/* Only dump oopses if dump_oops is set */
> >  	if (reason == KMSG_DUMP_OOPS && !dump_oops)
> 
> Thanks for your work on this!
> 
> John Ogness

Regards
Walter
