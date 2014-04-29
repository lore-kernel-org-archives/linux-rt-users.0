From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Subject: FIFO & workqueue
Date: Tue, 29 Apr 2014 11:11:23 +0530
Message-ID: <CAGZFCEFPoUtEBEsodXOtoGHc3d7oTLKsLwfo9OUV5Eh2Et219g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:47044 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbaD2Fr1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Apr 2014 01:47:27 -0400
Received: by mail-yh0-f48.google.com with SMTP id v1so3487481yhn.21
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Apr 2014 22:47:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I want to  use a real time kernel thread  So I created a workqueue
(create_workqueue) and changed its pritority to SCHED_FF.   This will
serve the purpose of
http://www.falsig.org/simon/blog/2013/07/10/real-time-linux-kernel-drivers-part-3-the-better-implementation/
 ?


if a user thread is  blocked on a poll(),  is there any performance
degrade if i  woke it from  the above workqueue thread ?


Thanks,
Ratheesh
