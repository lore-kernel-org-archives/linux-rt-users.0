From: rolf.freitag@email.de
Subject: Variance, Standard Deviation, Skewness and Kurtosis for cyclictest
 results?
Date: Sat, 24 Jun 2017 00:38:49 +0200
Message-ID: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "r t" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:54478 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbdFWWiv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2017 18:38:51 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

many programs, e. g. ping also print the standard deviation of the measured times, so i would like get the standard deviation(s) also from cyclictest.
It's easy to also calculate Variance, Skewness and Kurtosis in the same pass: https://www.johndcook.com/blog/skewness_kurtosis/
Has someone planned to implement this in cyclictest?

Regards,

Rolf
