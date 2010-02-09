From: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Subject: Converting a device driver for real time kernel
Date: Tue, 9 Feb 2010 09:32:30 -0000
Message-ID: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ukmta3.baesystems.com ([20.133.40.55]:6282 "EHLO
	ukmta3.baesystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab0BIJcc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2010 04:32:32 -0500
Received: from glkms1102.GREENLNK.NET (glkms1102.greenlnk.net [10.108.36.193])
	by baemasodc004.greenlnk.net (Switch-3.4.1/Switch-3.4.1) with ESMTP id o199WjUB008880
	for <linux-rt-users@vger.kernel.org>; Tue, 9 Feb 2010 09:32:45 GMT
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
 
What is the best way of converting an existing device driver to work
under a real-time kernel?
 
A device driver provided for a special serial card (Curtiss Wright SL240
sFDFP card http://www.cwcembedded.com/products/0/1/461.html) works under
vanilla Linux (SLES SP10 SP2 kernel 2.6.16.60-0.21-smp), but compiling
the driver under the real time kernel (2.6.22.19-0.14-rt) the system
locks up and crashes. The rt kernel is being used to write large amounts
of data from the serial card to disk and testing has found the rt kernel
has the best consistent write performance.
 
I have gone back to the supplier and they are not interested in
developing a real time version of the driver. So I am trying to modify
the driver myself. The driver code can be provided if anyone wants a
look (released under GPLv2).
 
Any assistance would be useful.

Regards,
Adam Leggo 
 

********************************************************************
This email and any attachments are confidential to the intended
recipient and may also be privileged. If you are not the intended
recipient please delete it from your system and notify the sender.
You should not copy it or use it for any purpose nor disclose or
distribute its contents to any other person.
********************************************************************

