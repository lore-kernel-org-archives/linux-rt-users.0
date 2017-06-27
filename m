From: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Subject: RE: Variance, Standard Deviation, Skewness and Kurtosis for
 cyclictest results?
Date: Tue, 27 Jun 2017 10:33:53 +0000
Message-ID: <AM3PR02MB1304DE1C5F622ABFC718C57C1DC0@AM3PR02MB130.eurprd02.prod.outlook.com>
References: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
 <20170626143035.kir3ym6so6yifrza@linutronix.de>
 <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
 <20170627081857.GD12810@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "rolf.freitag@email.de" <rolf.freitag@email.de>,
        r t <linux-rt-users@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve1eur01on0092.outbound.protection.outlook.com ([104.47.1.92]:17760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752484AbdF0KeB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jun 2017 06:34:01 -0400
In-Reply-To: <20170627081857.GD12810@osadl.at>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Nicholas,

I think Rolf is not talking about estimating of extreme values but calculat=
ing a simple measure, standard deviation.
You can always calculate in-sample deviation given a set of samples and it =
will give some additional insight into the nature of observed phenomena.
You can also apply tests of robustness and/or calculate all the statistical=
 hypothesis if you want to.
Rolf is likely talking about sane approach of having simple in-sample devia=
tion calculated though.

I agree with Sebastian that histogram does the job if you have histogram,
but assuming you want to have some script comparing results you need
this picture to be quantified, so producing deviation may be the way to go.

cheers,
Piotr=20

-----Original Message-----
From: Nicholas Mc Guire [mailto:der.herr@hofr.at]=20
Sent: 27 June 2017 09:19
To: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>; rolf.freitag@email.d=
e; r t <linux-rt-users@vger.kernel.org>
Subject: Re: Variance, Standard Deviation, Skewness and Kurtosis for cyclic=
test results?

On Mon, Jun 26, 2017 at 03:59:20PM +0000, Piotr Gregor wrote:
> Hi Sebastian,
>=20
> I think Rolf understands that but he is simply interested in deviation an=
yway.
> I can agree deviation gives some more insight into nature of latency=20
> observed even if it is clear then max peak is what determines=20
> real-timeness of the setup. One may be interested in distribution of=20
> latency - you may have two setups with same average and max peak while th=
ere is much less meaningful peaks on one than on the other.
>
you have to be careful here - any statistics estimation of the maximum with=
 e.g. asymtotic extreemvalue distribution is only valid if the data is in f=
act iid values. The problem is that it is not assured that you actually hav=
e a distribution (implying a stochastic process as source) but the max can =
be systematic problem e.g. SMIs or other HW effects that are do not follow =
a distribution at all - for estimation of extreemvalues the most important =
property is that the tail characteristic is resonably constant - any system=
atic effects could mess that up. So before trying to use any statistics you=
 need to verify that you actually have a stochastic process at the core - a=
nd if you want to use simple metrics that apply if normal-distribution can =
be assumed you need to verify this assumptions first rt-systems are rarely =
(if ever) normally distributed.

That ping is printing standard-deviations is a bit funny as network times n=
eed not be clean distributions at all (and by no means stable over time) an=
d the tail characteristics of ping are dependent on systematic effects (e.g=
.
bandwidth trhotling of providers etc.) so I would question the validity of =
such exercises - just producing numbers without checking precoditions is a =
well known method of missusing statistics. Even a ping in the local network=
 is multimodal and calculating a std-dev on it is quite meaningless.
as .

For some rt-systems it is resonably to do statistical estimations of means =
and extreem values based on measurement sets like you find in the QA-Farm b=
ut you can not do that with a single data set - bascially you treat the dat=
a sets as samples and then you can derive predictions for the system maximu=
m based on the distribution of the local maxima of each of the data sets (s=
ay 2h measurements each or so).

Off-topic side-note: If you do have a statiscially deterministic system (st=
able distribution, iid assumption holds, homoscedasticity, etc.) at the roo=
t - then you can in fact compensate jitter by replicaion over cores. So dep=
ending on what you want to achieve with the system a well behaved distribut=
ion with a max of 500us can actually provide guarantees of 400us response-t=
ime if you replicate the task and let the "winner" continue and the "looser=
" (task-replica) go to sleep again without performing any actions.

thx!
hofrat
