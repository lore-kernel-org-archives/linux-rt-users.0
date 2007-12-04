From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 00/23] RT balance v7
Date: Tue, 4 Dec 2007 22:27:05 +0100
Message-ID: <20071204212705.GA10360@elte.hu>
References: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:39950 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbXLDV1Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 16:27:25 -0500
Content-Disposition: inline
In-Reply-To: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> Ingo,
> 
> This series applies on GIT commit 
> 2254c2e0184c603f92fc9b81016ff4bb53da622d (2.6.24-rc4 (ish) git HEAD)

please post patches against sched-devel.git - it has part of your 
previous patches included already, plus some cleanups i did to them, so 
this series of yours wont apply. sched-devel.git is at:

 git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-sched-devel.git

	Ingo
