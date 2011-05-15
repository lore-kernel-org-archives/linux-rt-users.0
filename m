From: John Kacur <jkacur@redhat.com>
Subject: Re: merge of real-time 2.6.33.9-rt31 with stable 2.6.33.13
Date: Sun, 15 May 2011 10:54:37 +0200
Message-ID: <BANLkTim68rrUkRi0r-5xo4T10r5ALgcQhg@mail.gmail.com>
References: <alpine.LFD.2.00.1105141749180.29326@localhost6.localdomain6>
	<alpine.LFD.2.02.1105141827270.3078@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <Carsten.Emde@osadl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1105141827270.3078@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, May 14, 2011 at 6:28 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Sat, 14 May 2011, John Kacur wrote:
>> I did some light testing merging 2.6.33.13 into real-time 2.6.33.9-r=
t31.
>> In addition I cherry-picked 3c955b407a084810f57260d61548cc92c14bc627
>> in order to compile on newer distros.
>
> Thanks.
>
>> Here is the result of cyclic test on one machine
>> sudo ./cyclictest -t32 -p 80 -n -i 10000 -l 10000
>> policy: fifo: loadavg: 0.00 0.00 0.00 1/541 3759
>>
>> T: 0 ( 3728) P:80 I:10000 C: =A010000 Min: =A0 =A0 =A07 Act: =A0104 =
Avg: =A0114 Max: =A0 =A0 470
>
> The numbers are weird. How does that compare to older kernels on that
> machine with the same test?

Note this was on a machine with a straight Fedora install, and no -rt
packages or tuning. That being the case, the numbers are no better or
worse than recent -rt kernels. I can get you numbers with the last
kernel if you wish, on Monday. Perhaps Carsten would be interested in
running his tests?

John
