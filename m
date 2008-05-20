From: "Remy Bohmer" <linux@bohmer.net>
Subject: Compile warning rtmutex code on 2.6.24.7-rt8 (CC:LKML added)
Date: Tue, 20 May 2008 22:56:12 +0200
Message-ID: <3efb10970805201356x4552859bof5f3f4f56f2ba676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:29880 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754AbYETU41 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 16:56:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1485956ywe.1
        for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2008 13:56:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

 Do you recognise these warnings? I do not know (yet) if these are ARM
 specific...

  CC      kernel/rtmutex.o
 kernel/rtmutex.c: In function 'rt_write_fastlock':
 kernel/rtmutex.c:1582: warning: initialization makes pointer from
 integer without a cast
 kernel/rtmutex.c: In function 'rt_write_fasttrylock':
 kernel/rtmutex.c:1622: warning: initialization makes pointer from
 integer without a cast

 If so, do you have a fix for it?

 Regards,


 Remy
