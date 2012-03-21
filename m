From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in rt-migrate-test
Date: Wed, 21 Mar 2012 15:56:07 +0100
Message-ID: <CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	<b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
	<1332338731.23924.40.camel@gandalf.stny.rr.com>
	<4F69E940.9060808@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33793 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2CUO4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 10:56:08 -0400
Received: by yenl12 with SMTP id l12so986647yen.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 07:56:08 -0700 (PDT)
In-Reply-To: <4F69E940.9060808@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 21, 2012 at 3:44 PM, Darren Hart <dvhart@linux.intel.com> w=
rote:
>
>
> On 03/21/2012 07:05 AM, Steven Rostedt wrote:
>> On Tue, 2012-03-20 at 12:05 -0700, Darren Hart wrote:
>>
>>> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate=
-test/rt-migrate-test.c
>>> index 1963641..d2ac400 100644
>>> --- a/src/rt-migrate-test/rt-migrate-test.c
>>> +++ b/src/rt-migrate-test/rt-migrate-test.c
>>> @@ -532,7 +532,7 @@ int main (int argc, char **argv)
>>> =A0 =A0 =A0logdev_switch_set(1);
>>>
>>> =A0 =A0 =A0for (loop=3D0; loop < nr_runs; loop++) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0unsigned long long end;
>>> + =A0 =A0 =A0 =A0 =A0 =A0unsigned long long __attribute__ ((unused)=
) end;
>>
>> I don't like this. It seems to be a gcc bug. What version of gcc is
>> this?
>>
>
> gcc (GCC) 4.6.1 20110908 (Red Hat 4.6.1-9)
>

Yup, shows up on my F16 machine too, with a slightly different gcc vers=
ion.
gcc --version
gcc (GCC) 4.6.2 20111027 (Red Hat 4.6.2-1)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
