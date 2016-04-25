From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: Kernel RT questions
Date: Mon, 25 Apr 2016 14:37:59 +0200
Message-ID: <20160425143759.70061f10@archlinux.localdomain>
References: <1590963381.9624751461584677902.JavaMail.httpd@webmail-42.iol.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail230c50.megamailservers.eu ([91.136.10.240]:49006 "EHLO
	mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932174AbcDYNKG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2016 09:10:06 -0400
Received: from archlinux.localdomain (x4e32147b.dyn.telefonica.de [78.50.20.123])
	(authenticated bits=0)
	by mail37c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id u3PCbxmc008300
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Apr 2016 12:38:01 +0000
In-Reply-To: <1590963381.9624751461584677902.JavaMail.httpd@webmail-42.iol.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 25 Apr 2016 13:44:37 +0200 (CEST), helix250@libero.it wrote:
>root@beaglebone:~# uname -a
>Linux beaglebone 4.4.7 #2 SMP PREEMPT RT Thu Apr 21 14:48:58 CEST 2016 armv7l GNU/Linux
                                       ^^
                                       ^^

You are using a RT patched kernel. A kernel without the RT patch doesn't
include "RT", either for uname, nor for CONFIG_PREEMPT, but by using
"threadirqs" as boot option, a standard kernel has some RT abilities too.

As a side note, "cat /proc/config.gz | gunzip | grep PREEMPT" could be replaced
by "zgrep PREEMPT /proc/config.gz".
