From: "E-Blokos" <infos@e-blokos.com>
Subject: kernel 2.6.39
Date: Fri, 20 May 2011 16:58:10 -0400
Message-ID: <450FBA9CC12245C59BAF518CF94AC500@e1705>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ip-67-205-80-138.static.privatedns.com ([67.205.80.138]:25680
	"EHLO node250.e-blokos.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785Ab1ETU6M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 May 2011 16:58:12 -0400
Received: from e1705 (localhost.localdomain [127.0.0.1])
	by node250.e-blokos.com (8.14.3/8.14.3) with SMTP id p4KKwBoT007680
	for <linux-rt-users@vger.kernel.org>; Fri, 20 May 2011 16:58:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I saw in changelog of 2.6.39

commit 995612178c88407d8330f580ba6572cb8b284dd8
Merge: 8d7718aa082a 6d55da53db3d
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Sat Mar 12 11:37:14 2011 +0100

    Merge branch 'tip/futex/devel' of 
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt into 
core/futexes

     futex,plist: Pass the real head of the priority list to plist_del()
     futex,plist: Remove debug lock assignment from plist_node
     plist: Shrink struct plist_head
     plist: Add priority list test

does it mean that -RT option is now in the kernel core ?

Thanks 

