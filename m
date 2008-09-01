From: "Karthik Singaram Lakshmanan" <karthiksingaram@gmail.com>
Subject: Question regarding sched_setaffinity
Date: Sun, 31 Aug 2008 23:12:55 -0400
Message-ID: <1ca41c0f0808312012v4c52576cw307929992781eeca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:15987 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYIADM5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 31 Aug 2008 23:12:57 -0400
Received: by ti-out-0910.google.com with SMTP id b6so940386tic.23
        for <linux-rt-users@vger.kernel.org>; Sun, 31 Aug 2008 20:12:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
 I am a noob to SMP real-time scheduling in linux, I have a question of
sched_setaffinity(). If I restrict an application to a single CPU
using the appropriate cpumask for sched_setaffinity(), Is it
guaranteed that the kernel will never schedule it on any other CPU? I
am asking this because looking at kernel/sched.c seems to use
cpu_clear during load balancing. I am interested in knowing whether the
cache will be invalidated when my task is assigned to a single CPU.
Are there exceptions where the cpu-mask will be overridden?
Thanks for taking the time to answer my query.

Thanks,
Karthik
