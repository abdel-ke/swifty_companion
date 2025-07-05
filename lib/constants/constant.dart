const String intraURL = 'https://api.intra.42.fr';
const String authorizeURL = 'https://api.intra.42.fr/oauth/authorize';
const String tokenURL = 'https://api.intra.42.fr/oauth/token';
late String secretId;

const List<String> clustersSvg = [
  'assets/clustersSvg/khouribga-cluster-e1.svg',
  'assets/clustersSvg/khouribga-cluster-e2.svg',
  'assets/clustersSvg/khga-cluster-e3.svg',
];

const List<String> BGClustersSvgUrl = [
  'https://firebasestorage.googleapis.com/v0/b/credentials-d4ab7.appspot.com/o/bengurir%2Fe1.svg?alt=media&token=8118f5fd-d6c0-4845-954f-c7469c8749c9',
  'https://firebasestorage.googleapis.com/v0/b/credentials-d4ab7.appspot.com/o/bengurir%2Fe2.svg?alt=media&token=2e0bd009-a3de-4394-aa9d-e78a50fb26ba',
  'https://firebasestorage.googleapis.com/v0/b/credentials-d4ab7.appspot.com/o/bengurir%2Fc3.svg?alt=media&token=6b8d507d-ceed-4229-88c1-25f3bf1f28eb',
  'https://firebasestorage.googleapis.com/v0/b/credentials-d4ab7.appspot.com/o/bengurir%2Fc4.svg?alt=media&token=a2dc53a3-5d69-4a34-8cfc-d00229eada6c',
];
// const List<String> BGClustersSvgUrl = [
//   'assets/clustersSvg/bengurir/e1.svg',
//   'assets/clustersSvg/bengurir/e2.svg',
//   'assets/clustersSvg/bengurir/c3.svg',
//   'assets/clustersSvg/bengurir/c4.svg',
// ];

const List<String> MedClustersSvgUrl = [
  'https://firebasestorage.googleapis.com/v0/b/credentials-d4ab7.appspot.com/o/med%2Fc1.svg?alt=media&token=a2ee75de-a710-4335-8147-63f2846ac4d3',
  'https://firebasestorage.googleapis.com/v0/b/credentials-d4ab7.appspot.com/o/med%2Fc2.svg?alt=media&token=85a47fdb-ab80-4157-9f6d-36bfdc86bc8d'
];
// const List<String> MedClustersSvg = [
//   'assets/clustersSvg/med/c1.svg',
//   'assets/clustersSvg/med/c2.svg'
// ];

const List<String> clustersSvgUrl = [
  'https://cdn.intra.42.fr/cluster/image/7/khouribga-cluster-e1.svg',
  'https://cdn.intra.42.fr/cluster/image/8/khouribga-cluster-e2.svg',
  'https://cdn.intra.42.fr/cluster/image/207/khga-cluster-e3.svg',
];

const KHOURIBGAID = 16;
const BENGURIRID = 21;
const MEDID = 55;
const RABATID = 75;