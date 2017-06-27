From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: Variance, Standard Deviation, Skewness and Kurtosis for
 cyclictest results?
Date: Tue, 27 Jun 2017 08:18:57 +0000
Message-ID: <20170627081857.GD12810@osadl.at>
References: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
 <20170626143035.kir3ym6so6yifrza@linutronix.de>
 <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "rolf.freitag@email.de" <rolf.freitag@email.de>,
        r t <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 92-243-34-74.adsl.nanet.at ([92.243.34.74]:56525 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdF0I1p (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jun 2017 04:27:45 -0400
Content-Disposition: inline
In-Reply-To: <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 26, 2017 at 03:59:20PM +0000, Piotr Gregor wrote:
> Hi Sebastian,
> 
> I think Rolf understands that but he is simply interested in deviation anyway.
> I can agree deviation gives some more insight into nature of latency observed even if it is clear
> then max peak is what determines real-timeness of the setup. One may be interested in distribution
> of latency - you may have two setups with same average and max peak while there is much less
> meaningful peaks on one than on the other.
>
you have to be careful here - any statistics estimation of the maximum
with e.g. asymtotic extreemvalue distribution is only valid if the data
is in fact iid values. The problem is that it is not assured that you actually
have a distribution (implying a stochastic process as source) but
the max can be systematic problem e.g. SMIs or other HW effects that
are do not follow a distribution at all - for estimation of extreemvalues
the most important property is that the tail characteristic is resonably
constant - any systematic effects could mess that up. So before trying 
to use any statistics you need to verify that you actually have a stochastic
process at the core - and if you want to use simple metrics that apply if
normal-distribution can be assumed you need to verify this assumptions first
rt-systems are rarely (if ever) normally distributed.

That ping is printing standard-deviations is a bit funny as network times
need not be clean distributions at all (and by no means stable over time) and
the tail characteristics of ping are dependent on systematic effects (e.g.
bandwidth trhotling of providers etc.) so I would question the validity of
such exercises - just producing numbers without checking precoditions is a
well known method of missusing statistics. Even a ping in the local network 
is multimodal and calculating a std-dev on it is quite meaningless.
as .

For some rt-systems it is resonably to do statistical estimations of means
and extreem values based on measurement sets like you find in the QA-Farm
but you can not do that with a single data set - bascially you treat the
data sets as samples and then you can derive predictions for the system
maximum based on the distribution of the local maxima of each of the data
sets (say 2h measurements each or so).

Off-topic side-note: If you do have a statiscially deterministic system 
(stable distribution, iid assumption holds, homoscedasticity, etc.) at the 
root - then you can in fact compensate jitter by replicaion over cores. So
depending on what you want to achieve with the system a well behaved 
distribution with a max of 500us can actually provide guarantees of 
400us response-time if you replicate the task and let the "winner" continue 
and the "looser" (task-replica) go to sleep again without performing any 
actions.

thx!
hofrat
