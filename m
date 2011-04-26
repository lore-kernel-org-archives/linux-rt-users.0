From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/4] munmap: kbuild menu for munmap interface
Date: Tue, 26 Apr 2011 15:51:22 -0700
Message-ID: <BANLkTikVLj3W6dSNRERntjOcX0kh-wrJYg@mail.gmail.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	<1303728272-11408-4-git-send-email-leemgs1@gmail.com>
	<20110425084508.dda5ec8f.randy.dunlap@oracle.com>
	<BANLkTi=psQRm9W9uXBgCEyYp-oEA0d0GVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Geunsik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:48493 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758991Ab1DZWv0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Apr 2011 18:51:26 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p3QMpO9Z020526
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Apr 2011 15:51:24 -0700
Received: from yib19 (yib19.prod.google.com [10.243.65.83])
	by wpaz1.hot.corp.google.com with ESMTP id p3QMp5uh028842
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Apr 2011 15:51:22 -0700
Received: by yib19 with SMTP id 19so535602yib.18
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Apr 2011 15:51:22 -0700 (PDT)
In-Reply-To: <BANLkTi=psQRm9W9uXBgCEyYp-oEA0d0GVA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 25, 2011 at 5:42 PM, Geunsik Lim <leemgs1@gmail.com> wrote:
> I will modify contents that you commented.

Thank you for making the effort, but we would much prefer to eliminate
ZAP_BLOCK_SIZE than have a configurable ZAP_BLOCK_SIZE.  So I don't
think you need update the contents here.

Peter's preemptible mmu_gather work is expected to be included in the
next mmotm.  Please test on that, and if it does not meet your needs,
do let us know.

Thanks,
Hugh
