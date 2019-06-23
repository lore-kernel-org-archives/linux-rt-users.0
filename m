Return-Path: <SRS0=joET=UW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E4EC43613
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 Jun 2019 06:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5026220840
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 Jun 2019 06:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFWGUd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 23 Jun 2019 02:20:33 -0400
Received: from barracuda2.shentel.net ([204.111.1.145]:60990 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725268AbfFWGUd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 23 Jun 2019 02:20:33 -0400
X-ASG-Debug-ID: 1561270831-0ea5be476a2315cc0001-YwjLzG
Received: from mta-out1.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda1.shentel.net with ESMTP id vAEt2t2mtsAwAfEQ for <linux-rt-users@vger.kernel.org>; Sun, 23 Jun 2019 02:20:31 -0400 (EDT)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out1.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id AD3D5100083
        for <linux-rt-users@vger.kernel.org>; Sun, 23 Jun 2019 02:20:31 -0400 (EDT)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     linux-rt-users@vger.kernel.org
Subject: trying to build 4.16.18-rt9 on arm
Date:   Sun, 23 Jun 2019 02:20:30 -0400
X-ASG-Orig-Subj: trying to build 4.16.18-rt9 on arm
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201906230220.30922.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1561270831
X-Barracuda-URL: https://172.26.193.41:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 1694
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73027
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

And I am missing mkimage to build the uImage needed for an rpi-3b on the 
rpi-3b.

I have downloaded and unpacked tools-master.zip which does contain a 
mkimage directory.

Looks like this:
pi@picnc:/media/pi/workpi1/linux-rt-devel-4.16.18-rt9 $ 
ls -l ../tools-master/mkimage
total 48
-rw-r--r-- 1 pi pi   157 Jan 12  2018 args-uncompressed.txt
-rw-r--r-- 1 pi pi   201 Jan 12  2018 boot-uncompressed.txt
-rw-r--r-- 1 pi pi 32768 Jan 12  2018 first32k.bin
-rwxr-xr-x 1 pi pi   822 Jan 12  2018 imagetool-uncompressed.py
-rw-r--r-- 1 pi pi   343 Jan 12  2018 README

Where this is sitting is a long ways away from the rpi's $PATH.
And you can paint me bright green, never haveing attempted anything like 
this.

So what I am considering is composing a bash script named mkimage that is 
in $PATH, 
to exec

python /media/pi/workpi1/tools-master/mkimage/imagetool-uncompressed.py 

with the path to the (z)image file as its argument.

What I am unsure of is how to specify the output path so as to put the 
output file back into the kernel build tree so that a "make deb-pkg"
can find it.

So I could sure use some guidance.

Since this Makefile dates from 2002, is there a patch for it that will 
eliminate this bit of tom-foolery with a bash script? I'm trying to do 
this on raspian stretch installed on the rpi-3b.

Thank you all.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
