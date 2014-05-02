From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/3] rt: Move migrate_disable up in trylocks
Date: Fri, 02 May 2014 09:11:23 +0200
Message-ID: <5363451B.8080300@linutronix.de>
References: <20140501004757.583708392@goodmis.org> <20140501005004.241785945@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37279 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbaEBHL1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 03:11:27 -0400
In-Reply-To: <20140501005004.241785945@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/01/2014 02:47 AM, Steven Rostedt wrote:

Could this wait until it appears in the development release?

Sebastian
