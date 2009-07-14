From: Luca Abeni <lucabe72@gmail.com>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Tue, 14 Jul 2009 13:56:57 +0200
Message-ID: <4A5C7289.2080701@gmail.com>
References: <200907102350.47124.henrik@austad.us>	 <1247336891.9978.32.camel@laptop>  <4A594D2D.3080101@ittc.ku.edu>	 <1247412708.6704.105.camel@laptop> <1247499843.8107.548.camel@Palantir>	 <4A5B61DF.8090101@nortel.com>  <1247568455.9086.115.camel@Palantir> <1247569415.7500.95.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Linux RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail0.unitn.it ([193.205.206.51]:46843 "EHLO mail0.unitn.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbZGNMFO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2009 08:05:14 -0400
Received: from mail0.unitn.it (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 095F044295
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2009 13:56:36 +0200 (CEST)
Received: from mailhub2.unitn.it (mailhub2.unitn.it [192.168.206.47])
	by mail0.unitn.it (Postfix) with ESMTP id D05D444210
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2009 13:56:35 +0200 (CEST)
Received: from disi.unitn.it (brenta.disi.unitn.it [193.205.194.4])
	by mailhub2.unitn.it (Postfix) with ESMTP id C69F1B0D3D5
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2009 13:56:35 +0200 (CEST)
Received: from [193.205.213.42] (nowhere.science.unitn.it [193.205.213.42])
	(authenticated bits=0)
	by disi.unitn.it (8.13.8/8.13.8) with ESMTP id n6EBuZff027939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2009 13:56:35 +0200
In-Reply-To: <1247569415.7500.95.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Peter Zijlstra wrote:
> On Tue, 2009-07-14 at 12:47 +0200, Raistlin wrote:
>   
>> [1] http://feanor.sssup.it/%7Elipari/papers/rtss2001-bwi.ps.gz
>>     
>
> That link seems to require a user/pass combination.
>   
Sorry for jumping in the discussion :)
Anyway, you can look at the BWI technical report:
http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.24.3440
(click on the cached PDF), or you can search for
"Task synchronization in reservation-based real-time systems"
on google scholar (it is able to find a PDF for download).


                                           Luca
