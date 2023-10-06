Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3D38FBC
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3891595
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 12:13:10 -0700 (PDT)
Received: from [IPV6:2a01:e0a:244:b080:a267:71a:64f0:86b8] (unknown [IPv6:2a01:e0a:244:b080:a267:71a:64f0:86b8])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 59EC25FFC0;
	Fri,  6 Oct 2023 21:13:07 +0200 (CEST)
Message-ID: <32e50f01-ec19-74b5-227e-06f27af0f174@free.fr>
Date: Fri, 6 Oct 2023 21:13:07 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: rt-tests build failure on Fedora 39 with Python 3.12
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
References: <95ddebbf-25cf-d692-17f4-a7ecaceb9f6f@free.fr>
 <fc9828e0-8269-b85a-a732-1be188939b41@redhat.com>
Content-Language: en-US
From: Yann Collette <ycollette.nospam@free.fr>
In-Reply-To: <fc9828e0-8269-b85a-a732-1be188939b41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I was using the source from the 2.5 release.

Yann

Le 06/10/2023 à 20:44, John Kacur a écrit :
>
> On Wed, 4 Oct 2023, Yann Collette wrote:
>
>> Hello,
>>
>>
>> Rt-tests fails to build on Fedora 39 with python 3.12. The distutils module
>> has been removed from python 3.12.
>>
>> Is there a place where I can report the problem ?
> This was fixed upstream, are you using the source from Fedora?
>
> John
>
