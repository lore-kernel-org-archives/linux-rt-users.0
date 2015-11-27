From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH tip v4 2/5] [s]wait: Add compile time type check
 assertion
Date: Fri, 27 Nov 2015 21:10:00 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511272108570.3572@nanos>
References: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de> <1448370187-10075-3-git-send-email-daniel.wagner@bmw-carit.de> <5656F98D.70701@bmw-carit.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45304 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbbK0UKs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Nov 2015 15:10:48 -0500
In-Reply-To: <5656F98D.70701@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 26 Nov 2015, Daniel Wagner wrote:
> On 11/24/2015 02:03 PM, Daniel Wagner wrote:
> > The API provided by wait.h and swait.h is very similiar. Most of the
> > time your are only one character away from either of it:
> > 
> >      wake_up() vs swake_up()
> > 
> > This is on purpose so that we do not have two nearly identical bits of
> > infrastructre code with dissimilar names.
> > 
> > A compile time type check assertion ensures that obvious wrong usage
> > is caught at early stage.
> 
> Obviously, this didn't really work as one can see with patch #4. That
> one just compiled. So I wrapped almost all functions to get a better
> check coverage. woken_wake_function(), autoremove_wake_function() and
> wake_bit_function() can't be wrapped easily because DEFINE_WAIT and 
> friends. I just left them out. 
> 
> The result looks pretty bad in my opinion. Probably it would be
> better do add -Werror=incompatible-pointer-types to the CFLAGS.

That's really bad.

If we can pull off the -Werror=incompatible-pointer-types trick, that
would solve it nicely.
 
Thanks,

	tglx
