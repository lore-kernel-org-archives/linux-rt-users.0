From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.28-rt on PowerPC
Date: Fri, 30 Jan 2009 15:09:55 +1100
Message-ID: <1233288595.18767.20.camel__18729.935194324$1233288910$gmane$org@pasglop>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	 <1233281510.18767.17.camel@pasglop>
	 <20090130030758.GA7004@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <srostedt@redhat.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: avorontsov@ru.mvista.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755683AbZA3ENF@vger.kernel.org>
In-Reply-To: <20090130030758.GA7004@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> Actually, it doesn't matter whether a controller is a root IC or
> cascaded. Just as primary handlers, chained handlers don't run in
> threads, thus spinlocks should be used, not sleeping locks.

Sounds good then.

Cheers,
Ben.
