From: Victor henri <nadaeck@hotmail.com>
Subject: RE: 2.6.33-7-rt30 and 2.6.38 comparison
Date: Sat, 19 Mar 2011 01:40:58 +0100
Message-ID: <SNT110-W3899829B3D225E2BEC8CDDA8B30@phx.gbl>
References: <76D8B96C9CCF479A864872F2092B0C8F@e1705>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s4.snt0.hotmail.com ([65.55.90.15]:38133 "EHLO
	snt0-omc1-s4.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932622Ab1CSAk7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Mar 2011 20:40:59 -0400
In-Reply-To: <76D8B96C9CCF479A864872F2092B0C8F@e1705>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>




Hi

I have observed similar behavior with newer non-RT kernels but there we=
re something strange to me ;=20

Same results (very few X-runs, if any) with :

=A0=A0
 -=A0 on one hand, on an Asus laptop with a Core i3=A0 : latency 2.3 ms=
ec=20
with the 2.6.33.7.2-rt kernel and 23 msec with a 2.6.37 preempt kernel;

=A0=A0=A0
 -=A0 on the other hand, on a Lenovo Thinkpad Core i5 :  latency 2.3 ms=
ec=20
with the 2.6.33.7.2-rt kernel and 2.3 msec (yes the same) with a 2.6.37=
=20
preempt kernel !!

Of course the Lenovo Thinkpad is a very good laptop, but how come that =
there is such a big difference?=20

So, I have observed the same quality of performance as Madovsky but not=
=20
on every machine I've used... I don't have a clue why....

Victor

----------------------------------------
> From: infos@madovsky.org
> To: linux-rt-users@vger.kernel.org
> Subject: Re: 2.6.33-7-rt30 and 2.6.38 comparison
> Date: Fri, 18 Mar 2011 16:34:51 -0400
>
> I compiled 2.6.38 with exactly the same
> config so I made different audio/video task
> and very stable with short latency
>
>
> ----- Original Message -----
> From: "Madovsky"=20
> To: "linux-rt-users"=20
> Sent: Friday, March 18, 2011 4:28 PM
> Subject: Re: 2.6.33-7-rt30 and 2.6.38 comparison
>
>
> > not a lot, I'm only a rt user, not linux developer.
> > so my compare is only a view of for example
> > latency in audio/video....
> >
> >
> >> ----- Original Message -----
> >> From: "Ilyes Gouta"=20
> >> To: "Madovsky"=20
> >> Cc:=20
> >> Sent: Friday, March 18, 2011 4:16 PM
> >> Subject: Re: 2.6.33-7-rt30 and 2.6.38 comparison
> >>
> >>
> >>> Hi,
> >>>
> >>> Would you please elaborate a bit more?
> >>>
> >>> Thanks,
> >>>
> >>> -Ilyes
> >>>
> >>> On Fri, Mar 18, 2011 at 9:15 PM, Madovsky  wrote:
> >>>> Just tried to compare real time app
> >>>> at work with 2.6.33.7-rt30 and 2.6.38 and
> >>>> the result is 2.6.38 is very impressive...
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe
> >>>> linux-rt-users" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l
> >>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe
> >>> linux-rt-users" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> >>
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
