From: GeunSik Lim <leemgs1@gmail.com>
Subject: About "error mounting as ext3" when using 2.6.29-rt2 on Fedora.
Date: Fri, 3 Apr 2009 11:20:10 +0900
Message-ID: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:65319 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbZDCCUQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Apr 2009 22:20:16 -0400
Received: by wf-out-1314.google.com with SMTP id 29so957882wff.4
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Apr 2009 19:20:11 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, all.

This is Result about Booting using linux-2.6.29-rt2 Kernel on X86 Targets.
I used below desktop and netbook in this test.
-------------------------------------------------------------------------------------------------------------------------------------
CPU Info of Desktop/Netbook                               Kernel
        rootFS               Booting
-------------------------------------------------------------------------------------------------------------------------------------
Intel Atom(TM)  CPU N270   @ 1.60GHz /         Linux-2.6.29-rt2
Fedora 9          Success
Intel Core(TM)2 Quad CPU Q6600 @2.40GHz    same as above       CentOS
5.2      Success
Intel Core(TM)2 Quad CPU Q6600 @2.40GHz    same as above       Ubuntu
8.04      Success
Intel Core(TM)2 Quad CPU Q9300 @2.50GHz    same as above       Fedora
9           Fail(Always)
Intel Core(TM)2 Quad CPU Q8200 @2.33GHz    same as above       Fedora
9           Fail(Always)
-------------------------------------------------------------------------------------------------------------------------------------
-http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.29.tar.bz2
-http://www.kernel.org/pub/linux/kernel/projects/rt/older/patch-2.6.29-rt2.bz2
-config file: http://mfiles.naver.net/6eb85b8594cfa2143352/data42/2009/4/3/195/i386.2.6.29-rt2.ftrace.config-invain-invain.20090402?type=attachment

I captured when display error messages on console.
<error messages>
mount: error mounting /dev/root on /sysroot as ext3: No such file or
directory ......

2.6.29-rt1 kernel -->
http://blogfiles7.naver.net/data41/2009/3/31/22/panic.2.6.29-rt1_invain.png
2.6.29-rt2 kernel -->
http://blogfiles5.naver.net/data42/2009/4/2/164/2.6.29-rt2.error.q8200_invain.png


I read RedHat Bugzilla's pages about the problems.
for example,
https://bugzilla.redhat.com/show_bug.cgi?id=479188

Anyone have this problems on Fedora Linux Distribution with linux-2.6.29-rt2 ?

-- 
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
