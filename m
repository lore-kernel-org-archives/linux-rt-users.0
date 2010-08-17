From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Tue, 17 Aug 2010 08:54:40 -0700
Message-ID: <AANLkTimJUY3v47AxTC5MVA8outghpSYhXPDnnALE_Wqk@mail.gmail.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
	<AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Manikandan Ramachandran <crmanik@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35647 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab0HQPyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 11:54:44 -0400
Received: by eyg5 with SMTP id 5so2041356eyg.19
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 08:54:42 -0700 (PDT)
In-Reply-To: <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 16, 2010 at 11:07 PM, Manikandan Ramachandran
<crmanik@gmail.com> wrote:
> :
>>
>> Hello All,
>>
>> =C2=A0=C2=A0=C2=A0 I=C2=A0created a very simple program which has hi=
gher priority than normal tasks and runs a tight loop. Under same test =
environment I ran this program=C2=A0on both non-rt and rt=C2=A02.6.33.5=
 kernel.=C2=A0=C2=A0To my suprise I see that performance of non-RT=C2=A0=
kernel is better than RT. non-RT=C2=A0kernel took 3 sec and 366156 usec=
 while RT=C2=A0kernel took about 3 sec and 418011 usec.Can someone plea=
se explain why the performance of non-rt kernel is better than rt kerne=
l? From the face of the test result, I feel RT has more overhead,Is the=
re=C2=A0any configuration that I could do to bring down the overhead?
>>

I'm not a programmer so I'll leave it to someone else to comment on
the code. (If at all.)

In my mind the purpose of the rt-kernel is not to 'go faster' but
rather to manage the __latency__ on high priority events. I use
rt-sources for my real-time audio system. I need low latency to my
sound cards. With rt-sources I can set the priority of sound cards
higher than other parts of the hardware system, and with the priority
higher when they need to send or receive audio data it happens in a
known amount of time. Without rt-sources they may want access to the
system but a disk drive or the network can get in the way and cause
delays.

If your program is measuring time around a loop getting time of day
then that's not likely a good measurement. If you measure how much the
interrupt latency changes when a sound card interrupts and asks for
service then that's probably more of where you'll see the value.

Again, not a programmer.

Cheers,
Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
