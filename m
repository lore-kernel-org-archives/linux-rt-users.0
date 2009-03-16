From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: rt application question with rs232 communication
Date: Mon, 16 Mar 2009 16:05:15 -0400
Message-ID: <f96d234e0903161305q40b78e40neeeb0f1a4d4e9271@mail.gmail.com>
References: <f96d234e0903091434xafaedcamc68023ebce5c7799@mail.gmail.com>
	 <f96d234e0903100544p5bc17143l8916aefd49d78562@mail.gmail.com>
	 <c384c5ea0903141907o79ccd790h7b48605feaeba107@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:17753 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbZCPUFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2009 16:05:18 -0400
Received: by rv-out-0506.google.com with SMTP id g9so2204515rvb.5
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Mar 2009 13:05:15 -0700 (PDT)
In-Reply-To: <c384c5ea0903141907o79ccd790h7b48605feaeba107@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Mar 14, 2009 at 10:07 PM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
> Hello Cliff,
>
> On Tue, Mar 10, 2009 at 1:44 PM, Cliff Brake <cliff.brake@gmail.com> =
wrote:
>> Clarification, I don't have the RT patch applied, just CONFIG_PREEMP=
T
>> from Linus's kernel. =A0Reviewing my notes from several years ago, I=
 ran
>> into a similar issue and the RT patch fixed it, so now to figure out
>> the best way to get a recent RT patched ARM kernel ...
>>
>>> timing. =A0However, it seems that the system has trouble receiving =
the
>>> response in a timely fashion. =A0I often observe that it takes at l=
east
>>> 10ms for the application to receive the response data after the dat=
a
>>> has appeared on the rs232 bus. =A0Is the RT patch something that wo=
uld
>
> We are running a real-time RS-485 protocol where the time window is 1
> ms and only under heavy load we got deadline misses > 1 ms.
> Unfortunately I didn't measure the max latency then, but 10 ms sounds
> like excessive latency to me.
>
> Under 2.6.24.7-rt24 (or whatever -rtxy in that series) we have never
> missed the 1 ms deadline.

Thanks Leon.  I guess its pretty obvious at this point I need the RT
patch.  Still trying to figure out the best way to get this with
2.6.27 or later -- I really don't want to go back to 2.6.26.

Thanks,
Cliff

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cliff Brake
http://bec-systems.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
