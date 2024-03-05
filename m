Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730C3FB1B
	for <linux-rt-users@vger.kernel.org>; Tue,  5 Mar 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625475; cv=none; b=QvCSDp1pl4sXOU7MfT14GxC8trwrfls6b/uAqAJU3uDsegTuZ1PTO/KWMeOL+nI5AQ8kqprJbgXbqR/jqeZg2lNA/vx4kasRn+RNvIfuqh4XQmTGK2ggXNHgEm8T6+ADSf7H1ALh16PvX960euamUaciI47/Hjs93n9r8UM1n7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625475; c=relaxed/simple;
	bh=rpOzrjdZVmF5ZBI3MeEGxxWCMthl5wo/AQRyinnCScQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0s9xdcra+XmQTsBeWK3W/cLm5eIam2KcRXXe8omiOP915QUDLg6ZIojR3QIGKC6egM+QZfw3LBZVe7X52wDWT+sII2X3vWhFlJgHp4hHHWPJiTR3+jJais7eYODL4Ym1Ywnv9lvDOoBHdCGSOV/aJoC5BFjlarUmLxPR5vcI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jp7pLJA6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jp7pLJA6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4256SOk3009745;
	Tue, 5 Mar 2024 07:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a6/sGxar/1LRVB8TX1zmTrYWFoRzt6s5j5eniJMYBFQ=; b=Jp
	7pLJA6HD+t6EnFpnJUis5YTzG/aoAmXfRIgpa5K5GefXUH7tw/TUWb0gcuEksFq9
	N87rSQ3/MpsYi/KhlBzKBVqBxRFzQ+t8hCYWPJM6AB1oeTMi444CN9+yz9f/4R+/
	icGdRatbFlnoQl6svk8YxaNFCb7DH1RLEw+LCt7G5VagD0WhuNbtaTQJXveyxOsk
	xVQMBEoN0tkh+r8KRZl0LYA/M/tYf1tHw7cA9oURQfO3A9j5nwL+GogxbDH0iyUT
	g0MJxPmQ2RUEMavoN3iwcAjkMawPgf1Zdnv43LPMO+B7gx9w/EFy6F+It+GkoOxO
	bfYiXBYvEu3nPOGU8X3g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnu470fsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 07:57:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4257vfKM029022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 07:57:41 GMT
Received: from [10.217.241.99] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 23:57:39 -0800
Message-ID: <8fe5266e-b26e-4751-a6bf-0bb694a394d3@quicinc.com>
Date: Tue, 5 Mar 2024 13:27:26 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Fix NULL ptr dereference in nbcon driver
To: John Ogness <john.ogness@linutronix.de>, <linux-rt-users@vger.kernel.org>,
        <quic_akdwived@quicinc.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>
References: <20240222101626.1142-1-quic_chandna@quicinc.com>
 <874je04qqu.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Sahil Chandna <quic_chandna@quicinc.com>
In-Reply-To: <874je04qqu.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g51_eWEoT9zfqSYSkktrzd36ulsqmGDm
X-Proofpoint-GUID: g51_eWEoT9zfqSYSkktrzd36ulsqmGDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=800 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050062

On 2/22/2024 6:09 PM, John Ogness wrote:
> On 2024-02-22, Sahil Chandna <quic_chandna@quicinc.com> wrote:
>> Add a missing check in nbcon driver which is causing NULL pointer
>> dereference bug.
> 
> I believe the correct fix is here:
> 
> https://lore.kernel.org/lkml/20240123054033.183114-2-junxiao.chang@intel.com/
Thanks John for sharing this fix, i tried applying this patch locally in 
my workspace and see issue is resolved. However, when i am checking the 
same fix on patch-6.6.14-rt21.patch.gz on 
https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/, I don't 
see this fix. Even on latest stable version for 6.6. kernel i.e. 
patch-6.6.20-rt25.patch.gz, this fix is not present.

I see, the fix is available on 6.8 kernel i.e. 
patch-6.8-rc7-rt6.patch.gz patch but since i am working on 6.6 kernel 
these patches do not apply cleanly. Since, this issue is first reported 
on v6.6.10-rt18, so will the fix officially be released on all 6.6 
kernel sub-versions post 6.6.10-rt18 ?

> 
> John

