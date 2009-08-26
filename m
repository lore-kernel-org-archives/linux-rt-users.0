From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 19:16:12 +0300
Message-ID: <84144f020908260916l34a21cai1abf7b2ca7ac93a3@mail.gmail.com>
References: <1250983671.5688.21.camel@raz> <4A943A00.9080609@nortel.com>
	 <1251264700.7538.1178.camel@twins> <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	 <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>
	 <1251300625.18584.18.camel@twins>
	 <alpine.DEB.1.10.0908261136590.9933@gentwo.org>
	 <1251302598.18584.31.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux-foundation.org>,
	raz ben yehuda <raziebe@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com, mingo@elte.hu,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751740AbZHZQQO@vger.kernel.org>
In-Reply-To: <1251302598.18584.31.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,

On Wed, Aug 26, 2009 at 7:03 PM, Peter Zijlstra<peterz@infradead.org> wrote:
> There needs to be some communication between the isolated and non
> isolated part, otherwise what's the point. Even when you'd let it handle
> say a network device as pure firewall, you'd need to configure the
> thing, requiring interaction.

The use case Christoph described was an user-space number cruncher app
that does some network I/O over RDMA IIRC. AFAICT, if he could isolate
a physical CPU for the thing, there would be little or no
communication with the non-isolated part. Yes, the setup sounds weird
but it's a real workload although pretty damn specialized.

On Wed, Aug 26, 2009 at 7:03 PM, Peter Zijlstra<peterz@infradead.org> wrote:
>> > If you think the kernel is too fat and does superfluous things for your
>> > needs, help trim it.
>>
>> Mind boogling nonsense. Please stop fantasizing and trolling.
>
> Oh, to lay down the crack-pipe and sod off.

I guess I'll go for the magic mushrooms then.

                        Pekka
