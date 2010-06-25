From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: Can't logon (2.6.18-rt7)
Date: Fri, 25 Jun 2010 08:34:43 -0700
Message-ID: <1277480083.12664.6.camel@sven.oceanvoyage.org>
References: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B20B@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64469 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab0FYPer (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jun 2010 11:34:47 -0400
Received: by pvg2 with SMTP id 2so904638pvg.19
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jun 2010 08:34:46 -0700 (PDT)
In-Reply-To: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B20B@CARACALQ005.caracal01.greenstream.priv>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-06-25 at 15:31 +0100, Simpson, John (UK) (Contractor)
wrote:
> I'm re-posting this as I missed off the subject, plus I sort of fixed it
> after Denis Borisevitch's suggestion that I selectively disable the
> runlevel services in levels above level one until I found the one
> causing the problem. Being Friday afternoon and impatient for a result I
> disabled everything that didn't seem relevant and it worked so now I
> don't know what was wrong. The next problem is that the new kernel says
> that the NICs it reports correctly through lspci don't seem to be
> present when the network service runs, but I've been here before and I
> might just use some other NICs.  
> 
> 
> Repost:
> 
> I'm attempting to run a vanilla 2.6.18 from kernel.org patched with
> 2.6.18-rt7 (third party RPMs dictate this version) .

You can probably use RPM --nodeps in case you decide to use something
more recent.

You most likely will save a LOT of time updating the Kernel, vs. trying
to back-port all that crap. And I'd eyeball man-lives scale if you want
to do that solo.

OTOH, IIRC MontaVista had a supported 2.6.18 RT Kernel at some time
time, I am sure they would be glad to take 25K for it.


>  Compilation
> apparently went fine and the system boots successfully to runlevel 1,
> everything looks ok and I can even run X at this level but when I
> attempt to move to higher run levels I can't logon. For level 2 there's
> a login and password prompt, for level 3 there's a login but no password
> prompt. This is true for any user. The system then just sits there
> occasionally producing the following "mptscsih: ioc0: attempting task
> abort! ....." plus similar stuff related to mptscsih.
> 

I recall some fixes done on these drivers along the way - wouldn't know
where to begin.

Sven

> Running with the original kernel (a Centos 2.6.18) everything's fine.
> 
> Does this ring any bells with anyone?
> 
> John 
> 
> 
> ********************************************************************
> This email and any attachments are confidential to the intended recipient and may also be privileged. If you are not the intended recipient please delete it from your system and notify the sender. You should not copy it or use it for any purpose nor disclose or distribute its contents to any other person. 
> 
> MBDA UK Limited, a company registered in England and Wales, registration number 3144919 whose registered office is at Six Hills Way, Stevenage, Hertfordshire, SG1 2DA, England.
> ********************************************************************
> 
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email 
> ______________________________________________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


