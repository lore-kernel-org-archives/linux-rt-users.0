From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: Variance, Standard Deviation, Skewness and Kurtosis for
 cyclictest results?
Date: Tue, 27 Jun 2017 11:39:13 +0000
Message-ID: <20170627113913.GA16152@osadl.at>
References: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
 <20170626143035.kir3ym6so6yifrza@linutronix.de>
 <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
 <20170627081857.GD12810@osadl.at>
 <AM3PR02MB1304DE1C5F622ABFC718C57C1DC0@AM3PR02MB130.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "rolf.freitag@email.de" <rolf.freitag@email.de>,
        r t <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 92-243-34-74.adsl.nanet.at ([92.243.34.74]:56658 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdF0Ljj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jun 2017 07:39:39 -0400
Content-Disposition: inline
In-Reply-To: <AM3PR02MB1304DE1C5F622ABFC718C57C1DC0@AM3PR02MB130.eurprd02.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jun 27, 2017 at 10:33:53AM +0000, Piotr Gregor wrote:
> Hi Nicholas,
> 
> I think Rolf is not talking about estimating of extreme values but calculating a simple measure, standard deviation.
> You can always calculate in-sample deviation given a set of samples and it will give some additional insight into the nature of observed phenomena.
> You can also apply tests of robustness and/or calculate all the statistical hypothesis if you want to.
> Rolf is likely talking about sane approach of having simple in-sample deviation calculated though.

You can always calculate in-sample deviations - but are they meaningufl ?
You are making assumptions on the distribution that may or may not hold
and that is why you can not do "simplly in-sample deviations" they are
meaningless as a metric.

> 
> I agree with Sebastian that histogram does the job if you have histogram,
> but assuming you want to have some script comparing results you need
> this picture to be quantified, so producing deviation may be the way to go.

unfortnuaately you can not do that - it would be nice - but its not possible
you can do this but you are just generating numeric noise - there is no meaning
of a standard deviation if you underlying process is not a single process (
or the summation of well-behaved stochastic processes) but a set of 
independent stochastic processes that is producing cumulative effects.

If you want to do statistic trending (thats what it seems you are trying to)
then you need a model that faithfuly approximates the underlying process that
is "emitting" the data you are looking at - you can not simply make assumptions
of normality.

If you want to compare performance trends for RT then fire up R - build a 
model for an asymptotic extreem value distribution (probably type II Frechet
distributions for maximum would be the most suitable one). Its not impossible
to automate - but its not going to be simple ither - your steps are basically
 1) identify the distribution in the current data set.
 2) verify that your data sets are more or less homogenous.
 3) compare if the new data set fits the trend of previous data sets by
    looking at appropriate extreemalue distributions.

Just generating in-sample numbers that have no meaning is not going to help.

thx!
hofrat
