Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 13:39:13 PST
Received: from mwweb08oc.mail2world.com (mwweb08oc.mail2world.com [74.202.142.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FAD60
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 13:39:13 -0800 (PST)
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
	 Fri, 24 Nov 2023 13:38:12 -0800
auth-sender:gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
	Fri, 24 Nov 2023 13:38:11 -0800
Message-ID: <2f9e63d6-7fb4-4fb7-93cc-b50baad9c959@shentel.net>
Date: Fri, 24 Nov 2023 16:38:11 -0500
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
Content-Language: en-US
To: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
References: <20231123072436.270267-1-tglozar@redhat.com>
 <20231123072436.270267-3-tglozar@redhat.com>
 <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com>
 <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com>
 <b0becd53-9629-51de-4f88-776d2b59f4f5@redhat.com>
 <CAP4=nvTpOYvLoDMFpDcxHuFTMcyr5tdmuPM0W0pvZxrXkOHVPQ@mail.gmail.com>
From: gene heskett <gheskett@shentel.net>
In-Reply-To: <CAP4=nvTpOYvLoDMFpDcxHuFTMcyr5tdmuPM0W0pvZxrXkOHVPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F17.656117C4.0037,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 24 Nov 2023 21:38:12.0289 (UTC) FILETIME=[86435310:01DA1F1E]

On 11/24/23 11:52, Tomas Glozar wrote:
> pá 24. 11. 2023 v 16:27 odesílatel John Kacur <jkacur@redhat.com> napsal:
>> Or just check cpu1 like we already do!
>>
>> John
> 
> That won't work on machines that have only one CPU though.

Does that flavor actually exist? 4 seems to be pretty std now.

> 
> 
> .

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
  soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
  - Louis D. Brandeis

