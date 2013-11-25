From: Daniel Wagner <wagi@monom.org>
Subject: Re: Realtime Workshop Slides?
Date: Mon, 25 Nov 2013 13:42:49 +0100
Message-ID: <529345C9.2010707@monom.org>
References: <5293140D.8040003@monom.org> <20131125111526.5e17c989@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?B?UGhpbGlwcCDDnGJlcmJhY2hlcg==?= <murks@tuxfamily.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:50004 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab3KYMmu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Nov 2013 07:42:50 -0500
In-Reply-To: <20131125111526.5e17c989@eeyore>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Philipp,

On 11/25/2013 11:15 AM, Philipp =C3=9Cberbacher wrote:
> On Mon, 25 Nov 2013 10:10:37 +0100
> Daniel Wagner <wagi@monom.org> wrote:
>
>> Hi Steven,
>>
>> I'd like to write up a summary how to write a RT application. Instea=
d
>> of writing yet another document, I really like to extend (if needed)
>> this here
>>
>> https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
>>
>> My memory is quite bad so I am not sure if there is anything missing
>> on this page, compared with your presentation durin the RTWS.
>> If you don't mind sharing the slide, I could try to add missing
>> stuff :)
>>
>> (Obviously, it will be in Engrish :P)
>>
>> cheers,
>> daniel
>
> Hi Daniel, hi list.

I think your mail didn't make it to list so far (at least there is
no Cc).

> I would appreciate such a thing (for the time when I finally come
> around to write some audio application).

Looking forward to it :)

> One thing that's a bit unclear to me: should mlockall() be used with
> the MCL_FUTURE flag? Or to rephrase this, does mlockall(MCL_FUTURE)
> somehow look ahead and immediately lock all pages the process will ev=
er
> need?

According mlockall() man page:

        MCL_CURRENT Lock all pages which are currently  mapped  into  t=
he  address  space  of  the
                    process.

        MCL_FUTURE  Lock  all pages which will become mapped into the a=
ddress space of the process
                    in the future.  These could be for instance new pag=
es required  by  a  growing
                    heap and stack as well as new memory mapped files o=
r shared memory regions.

        If  MCL_FUTURE  has been specified, then a later system call (e=
=2Eg., mmap(2), sbrk(2), mal=E2=80=90
        loc(3)), may fail if it would cause the number of locked bytes =
 to  exceed  the  permitted
        maximum  (see below).  In the same circumstances, stack growth =
may likewise fail: the ker=E2=80=90
        nel will deny stack expansion and deliver a SIGSEGV signal to t=
he process.

Mostlikely you want to use both flags. See also the examples

https://rt.wiki.kernel.org/index.php/Simple_memory_locking_example
https://rt.wiki.kernel.org/index.php/Dynamic_memory_allocation_example
https://rt.wiki.kernel.org/index.php/Threaded_RT-application_with_memor=
y_locking_and_stack_handling_example

> Another useful thing would be a (probably incomplete) list of common
> calls that are known to cause problems in an rt context.

Absolutely.

cheers,
daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
