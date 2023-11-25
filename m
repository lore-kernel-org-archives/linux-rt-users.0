Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kwwMEFnR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3634FEA
	for <linux-rt-users@vger.kernel.org>; Sat, 25 Nov 2023 10:53:34 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3APIlA4i017676
	for <linux-rt-users@vger.kernel.org>; Sat, 25 Nov 2023 18:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : from : content-type : content-transfer-encoding;
 s=qcppdkim1; bh=H7873AWeJ02iqwCo9HKiENAQp2MT/cUtC42GXcWUB1s=;
 b=kwwMEFnReT+/RUqEh18mwqUq40wJd8Jxkm7KdmVAn6ZmM00o6l0HcvLA4+iqzAxSz6Dh
 CfQaqDNa2ZlrX7J7oq/su5PPLpPg1LXpILmtoH9ajbaK5L8Q17RnNEEXzB+AEEtNi/BW
 mwqO9YfykN/nTF2i1JQFBThcANSMI8sc7U5Br0oekWJXNjrsOY4PBhPGcvCgUBLHfMwU
 0b15wm5HB5HmX9WJ4vMuZUbuwOYDEYeVhB7w5bZxynORNxWvkpwModqFXkIC8lDs2Sj1
 CKrZ+NqzAS/oka0U72hlqJ8ZWprWCjbT9tU6n0eWN14IfLANT2kyB/e00X/f1EvmnATD cg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9pph3ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Sat, 25 Nov 2023 18:53:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3APIrXML001738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Sat, 25 Nov 2023 18:53:33 GMT
Received: from [10.216.60.253] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 25 Nov
 2023 10:53:32 -0800
Message-ID: <3d8f9a4a-f441-436e-bf60-95c3603531d8@quicinc.com>
Date: Sun, 26 Nov 2023 00:23:15 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <linux-rt-users@vger.kernel.org>
From: Sahil Chandna <quic_chandna@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f5JzhzGqfVZazNQwQNJWe7ARzfCuuj1V
X-Proofpoint-GUID: f5JzhzGqfVZazNQwQNJWe7ARzfCuuj1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_18,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 priorityscore=1501
 phishscore=0 mlxlogscore=228 suspectscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=1 bulkscore=0 spamscore=1 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311250142

subscribe linux-rt-users
