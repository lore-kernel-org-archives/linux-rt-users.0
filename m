From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 18:06:21 +0300
Message-ID: <84144f020908260806pb85ee72r7b7e32a07b921b59@mail.gmail.com>
References: <1250983671.5688.21.camel@raz>
	 <1251222993.7023.53.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251402300.17963@gentwo.org>
	 <1251227322.7538.1172.camel@twins> <4A943A00.9080609@nortel.com>
	 <1251264700.7538.1178.camel@twins> <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	 <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Christoph Lameter <cl@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com, mingo@elte.hu,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: raz ben yehuda <raziebe@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751416AbZHZPGW@vger.kernel.org>
In-Reply-To: <1251298443.4791.7.camel@raz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Aug 26, 2009 at 5:54 PM, raz ben yehuda<raziebe@gmail.com> wrote:
>> I have always been fascinated by the idea of controlling another cpu
>> from the main CPU.
>>
>> Usually these cpus are custom, run proprietary software, and have no
>> datasheet on their I/O interfaces.
>>
>> But, being able to turn an ordinary CPU into something like that seems
>> to be very nice.
>>
>> For example, It might help with profiling. Think about a program that
>> can run uninterrupted how much it wants.
>>
>> I might even be better, if the dedicated CPU would use a predefined
>> reserved memory range (I wish there was a way to actually lock it to
>> that range)
>>
>> On the other hand, I could see this as a jump platform for more
>> proprietary code, something like that: we use linux in out server
>> platform, but out "insert buzzword here" network stack pro+ can handle
>> 100% more load that linux does, and it runs on a dedicated core....
>>
>> In the other words, we might see 'firmwares' that take an entire cpu for
>> their usage.
>
> This is exactly what offsched (sos) is. you got it. SOS was partly inspired by the notion of a GPU.

So where are the patches? The URL in the original post returns 404...
