From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH -v2 4/7] RT overloaded runqueues accounting
Date: Mon, 22 Oct 2007 23:19:25 -0700
Message-ID: <20071022231925.2b996db8.pj@sgi.com>
References: <20071023025900.927578809@goodmis.org>
	<20071023032916.651749224@goodmis.org>
	<20071022211709.7be79fea.pj@sgi.com>
	<6599ad830710222311x402c3d1agcc458742fb5e219c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, mingo@elte.hu,
	dmitry.adamushko@gmail.com, ghaskins@novell.com,
	a.p.zijlstra@chello.nl
To: "Paul Menage" <menage@google.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:40673 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbXJWGTa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 02:19:30 -0400
In-Reply-To: <6599ad830710222311x402c3d1agcc458742fb5e219c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Paul M wrote:
> Cgroups doesn't change the locking rules for accessing a cpuset from a
> task - you have to have one of:

Good - could you comment task_cs() with this explanation?

The rules are derived from the cpuset rules, as you explain,
and as I suspected, but now task_cs() is the most popular
way to access a tasks cpuset from code within kernel/cpuset.c,
and that's code you added.

The reason that I started this subthread is that I didn't see
any immediate evidence that the RT code was honoring this locking,
and I suspected that I clear comment over task_cs() could have
clarified that for them.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
