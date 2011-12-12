From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.0.12-rt30
Date: Mon, 12 Dec 2011 15:59:21 -0800
Message-ID: <4EE69559.8030200@am.sony.com>
References: <1323302027.30977.117.camel@frodo>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:27941 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1LLX7f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Dec 2011 18:59:35 -0500
In-Reply-To: <1323302027.30977.117.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/07/11 15:53, Steven Rostedt wrote:
> 
> Dear RT Folks,
> 
> I'm pleased to announce the 3.0.12-rt30 stable release.
 
Builds and boots on some ARM boards

  In tree boards:

    PandaBoard
    Realview

  Out of tree boards:

    NaviEngine

for the following configurations:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

-Frank


