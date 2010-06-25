From: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Subject: Can't logon (2.6.18-rt7)
Date: Fri, 25 Jun 2010 15:31:55 +0100
Message-ID: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B20B@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail205.messagelabs.com ([85.158.140.179]:54414 "EHLO
	mail205.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab0FYOcE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jun 2010 10:32:04 -0400
Received: from partner1.mbda.co.uk (partner1.mbda.co.uk [10.15.19.7])
	by smtp2.mbda.co.uk (Switch-3.4.3/Switch-3.4.3) with ESMTP id o5PESotx007247
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jun 2010 15:28:50 +0100
Received: from caracals315.caracal01.greenstream.priv ([10.180.6.52])
	by partner1.mbda.co.uk (Switch-3.4.3/Switch-3.4.3) with ESMTP id o5PEVuAm012264
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jun 2010 15:31:56 +0100
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm re-posting this as I missed off the subject, plus I sort of fixed it
after Denis Borisevitch's suggestion that I selectively disable the
runlevel services in levels above level one until I found the one
causing the problem. Being Friday afternoon and impatient for a result I
disabled everything that didn't seem relevant and it worked so now I
don't know what was wrong. The next problem is that the new kernel says
that the NICs it reports correctly through lspci don't seem to be
present when the network service runs, but I've been here before and I
might just use some other NICs.  


Repost:

I'm attempting to run a vanilla 2.6.18 from kernel.org patched with
2.6.18-rt7 (third party RPMs dictate this version) . Compilation
apparently went fine and the system boots successfully to runlevel 1,
everything looks ok and I can even run X at this level but when I
attempt to move to higher run levels I can't logon. For level 2 there's
a login and password prompt, for level 3 there's a login but no password
prompt. This is true for any user. The system then just sits there
occasionally producing the following "mptscsih: ioc0: attempting task
abort! ....." plus similar stuff related to mptscsih.

Running with the original kernel (a Centos 2.6.18) everything's fine.

Does this ring any bells with anyone?

John 


********************************************************************
This email and any attachments are confidential to the intended recipient and may also be privileged. If you are not the intended recipient please delete it from your system and notify the sender. You should not copy it or use it for any purpose nor disclose or distribute its contents to any other person. 

MBDA UK Limited, a company registered in England and Wales, registration number 3144919 whose registered office is at Six Hills Way, Stevenage, Hertfordshire, SG1 2DA, England.
********************************************************************

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
