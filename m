From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 11:41:51 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0908261136590.9933@gentwo.org>
References: <1250983671.5688.21.camel@raz>  <1251004897.7043.70.camel@marge.simson.net> <1251018551.3810.35.camel@raz>  <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz>  <1251021133.14003.172.camel@marge.simson.net>
 <alpine.DEB.1.10.0908251122020.26329@gentwo.org>  <1251222993.7023.53.camel@marge.simson.net>  <alpine.DEB.1.10.0908251402300.17963@gentwo.org>  <1251227322.7538.1172.camel@twins>  <4A943A00.9080609@nortel.com>  <1251264700.7538.1178.camel@twins>
 <1251282598.3514.20.camel@raz>  <alpine.DEB.1.10.0908260943090.9924@gentwo.org>  <1251297910.1791.22.camel@maxim-laptop>  <1251298443.4791.7.camel@raz> <1251300625.18584.18.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: raz ben yehuda <raziebe@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com, mingo@elte.hu,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751532AbZHZPmF@vger.kernel.org>
In-Reply-To: <1251300625.18584.18.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 26 Aug 2009, Peter Zijlstra wrote:

> Why waste a whole cpu for something that could be done by part of one?

Because of latency and performance requirements

> You're bound to have interaction between the core os and these
> partitions you want, non of it different from how threads in the kernel
> would interact, other than that you're going to re-invent everything
> already present in the kernel.

The kernel interactions can be done while running on another (not
isolated) cpu.

> You don't, you make things more complex by introducing duplicate
> functionality.

The functionality does not exist. This is about new features.

> If you think the kernel is too fat and does superfluous things for your
> needs, help trim it.

Mind boogling nonsense. Please stop fantasizing and trolling.
