From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: Re: print user stack
Date: Sat, 23 Oct 2010 20:01:19 +0530
Message-ID: <AANLkTi=5Odw1sOWqXLD1Kxg4c-evTNt-dWzyxQUNFGix@mail.gmail.com>
References: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
	<20101023132629.GC3163@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61469 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab0JWObU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Oct 2010 10:31:20 -0400
Received: by iwn34 with SMTP id 34so2198381iwn.19
        for <linux-rt-users@vger.kernel.org>; Sat, 23 Oct 2010 07:31:20 -0700 (PDT)
In-Reply-To: <20101023132629.GC3163@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Oct 23, 2010 at 6:56 PM, Luis Claudio R. Goncalves
<lclaudio@uudg.org> wrote:
>but have you verified your core file size limit
>(ulimit -c)?

Yes. it is unlimited.

-Ratheesh

> On Sat, Oct 23, 2010 at 05:46:35PM +0530, ratheesh k wrote:
> | I had a strange problem of core file getting truncated. I could not
> | find any stack trace.
> |
> |
> | So, i wrote a kernel module. Which will find a =A0task_struct using=
 pid.
> | =A0find_task_jby_pid.
> | then i used show_stack for the same task struct to list out the sta=
ck
> | trace. But it is printing the kernel stack not user stack. Any idea
> | how to print user stack .
>
> Sorry if that sounds silly, but have you verified your core file size=
 limit
> (ulimit -c)?
>
> About printing the user stack from whithin the kernel, I understand t=
he
> utrace folks were working on that.
>
> Cheers,
> Luis
>
>
> --
> [ Luis Claudio R. Goncalves =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Ba=
ss - Gospel - RT ]
> [ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9 =A02696 7203 D980 A448 C8F8 ]
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
