From: Grammostola Rosea <rosea.grammostola-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [LAU] [Fwd: Re: realtime kernel for Debian]
Date: Tue, 24 Mar 2009 16:42:05 +0100
Message-ID: <49C8FF4D.1040204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060408060306030307000000"
To: pkg-multimedia-maintainers-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org,
	linux-audio-user <linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------060408060306030307000000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

There is an promising discussion on the debian-dev mailinglist. Maybe 
some people who knows more about realtime kernels could join. Also users 
who might want to have an realtime kernel in Debian and/or want help 
testing could join the discussion. I think it would be nice if there is 
also an realtime kernel in Debian or that the default kernel would be 
improved for realtime (audio) usage.


http://www.debian.org/MailingLists/subscribe

\r

--------------060408060306030307000000
Content-Type: message/rfc822;
 name="Re: realtime kernel for Debian.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: realtime kernel for Debian.eml"

X-Account-Key: account6
X-Mozilla-Keys: 
Delivered-To: rosea.grammostola-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Received: by 10.223.113.73 with SMTP id z9cs21839fap;
        Tue, 24 Mar 2009 05:27:11 -0700 (PDT)
Received: by 10.223.105.195 with SMTP id u3mr7042507fao.13.1237897631472;
        Tue, 24 Mar 2009 05:27:11 -0700 (PDT)
Return-Path: <bounce-debian-devel=rosea.grammostola=gmail.com-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
Received: from liszt.debian.org (liszt.debian.org [82.195.75.100])
        by mx.google.com with ESMTP id 12si3539083fxm.88.2009.03.24.05.27.11;
        Tue, 24 Mar 2009 05:27:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of bounce-debian-devel=rosea.grammostola=gmail.com-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org designates 82.195.75.100 as permitted sender) client-ip=82.195.75.100;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of bounce-debian-devel=rosea.grammostola=gmail.com-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org designates 82.195.75.100 as permitted sender) smtp.mail=bounce-debian-devel=rosea.grammostola=gmail.com-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id DE59E13A60F3; Tue, 24 Mar 2009 12:27:05 +0000 (UTC)
Old-Return-Path: <cate-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on liszt.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=4.0 tests=FOURLA,LDO_WHITELIST,
	RCVD_IN_DNSWL_MED autolearn=failed version=3.2.3
X-Original-To: lists-debian-devel-1HHIdfaasAxuHlm7Suoebg@public.gmane.org
Delivered-To: lists-debian-devel-1HHIdfaasAxuHlm7Suoebg@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id A6BCC13A6054
	for <lists-debian-devel-1HHIdfaasAxuHlm7Suoebg@public.gmane.org>; Tue, 24 Mar 2009 12:26:56 +0000 (UTC)
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id 24492-91 for <lists-debian-devel-1HHIdfaasAxuHlm7Suoebg@public.gmane.org>;
	Tue, 24 Mar 2009 12:26:53 +0000 (UTC)
X-policyd-weight: DYN_NJABL=ERR NOT_IN_SBL_XBL_SPAMHAUS=-1.5 NOT_IN_BL_NJABL=-1.5 DSBL_ORG=ERR CL_IP_EQ_HELO_IP=-2 (check from: .debian. - helo: .xsmtp0.ethz. - helo-domain: .ethz.)  FROM/MX_MATCHES_NOT_HELO(DOMAIN)=0 <client=82.130.70.14> <helo=xsmtp0.ethz.ch> <from=cate-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> <to=debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>, rate: -5
Received: from XSMTP0.ethz.ch (xsmtp0.ethz.ch [82.130.70.14])
	by liszt.debian.org (Postfix) with ESMTP id 8273413A5F0B
	for <debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>; Tue, 24 Mar 2009 12:26:38 +0000 (UTC)
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Mar 2009 13:26:35 +0100
Received: from [82.130.121.208] ([82.130.121.208]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Mar 2009 13:26:36 +0100
Message-ID: <49C8D17B.7000905-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Date: Tue, 24 Mar 2009 13:26:35 +0100
From: "Giacomo A. Catenazzi" <cate-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Subject: Re: realtime kernel for Debian
References: <49C3A1ED.1030302-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <219871bf0903221215n39a9ec16h74c71678500b8807-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> <49C8B51A.3010504-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <49C8BB66.6010509-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> <20090324114657.GO11087@rivendell>
In-Reply-To: <20090324114657.GO11087@rivendell>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2009 12:26:36.0385 (UTC) FILETIME=[C640A510:01C9AC7B]
X-Virus-Scanned: at lists.debian.org with policy bank en-ht
X-Amavis-Spam-Status: No, score=-6.9 tagged_above=3.6 required=5.3
	tests=[BAYES_00=-2, FOURLA=0.1, LDO_WHITELIST=-5]
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
Resent-Message-ID: <q8wxHOc046P.A.K-C.ZGNyJB@liszt>
Resent-From: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
X-Mailing-List: <debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org> archive/latest/248894
X-Loop: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: <debian-devel.lists.debian.org>
List-Post: <mailto:debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
List-Help: <mailto:debian-devel-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=help>
List-Subscribe: <mailto:debian-devel-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-devel-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-devel-request-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Resent-Date: Tue, 24 Mar 2009 12:27:05 +0000 (UTC)

Raphael Hertzog wrote:
> On Tue, 24 Mar 2009, Giacomo A. Catenazzi wrote:
>> Do you really need real time kernel?
>> Debian is a technical driven project, but reading the previous two quotes,
>> "real time" is used as marketing thing.
> 
> It's good to question the use of any feature, but a real-time kernel is
> certainly very useful in many industrial applications and Debian is
> popular in that field. (Don't put a marketing label on anything where
> you are not yourself sure of your expertise.)

Yes, I didn't write very well my sentence: the previous quotes was more
about "there exist rt kernels", "ubuntu has a rt kernel", but not solid
requirements. I had to write some "seems", and I'm sorry for the two
quoted people if it seems an attack.
Anyway, later in the mail, I asked for precise needs, so we could see
better what we should improve.

IMHO most users want a low latency kernel, but not a slower kernel, so
a CONFIG_HZ_1000 would be nice.  But the original post was about
multimedia production (and not reproduction), so the needs are probably
other.

My point was more:
- Debian has not rt kernel. Why? Non DD interested or/and low demand?
   This is an important point. We must not produce a rt-kernel if
   we cannot provide testers and developers (in unstable).
- kernel management is a weak point in distribution: no good method
   for kernel dependencies, using full capabilities, ...

so IMHO we should try harder with the normal kernel, so that we
can use the same infrastructure and testers. If we fail and we
are able to support rt kernels, IMO it is good to provide it in Debian.

The original mail was about "multimedia production" and few year ago kernel
developers had a lot of interaction with music industries.
I'm not an expert in the field, but how far are we in their need with
standard kernels?)


> I do use a real-time kernel on a Debian based system for one of my
> customers (but I have to recompile the kernel anyway because I do other
> customizations) and I have good reasons to do so because I can't suffer
> serial overrun and I must ensure that the serial interrupt handler
> is run in the required time and that no other (kernel) task has higher
> priority.

These *other customizations* are important to rt-kernel. So we need
a person (or more) that know the needs and could support us.
"realtime" alone is only a label ;-)

ciao
	cate


-- 
To UNSUBSCRIBE, email to debian-devel-REQUEST-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
with a subject of "unsubscribe". Trouble? Contact listmaster-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org



--------------060408060306030307000000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-audio-user mailing list
Linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user

--------------060408060306030307000000--
